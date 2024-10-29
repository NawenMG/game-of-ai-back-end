# app/controllers/users_soap_controller.rb
class UsersSoapController < ApplicationController
  protect_from_forgery with: :null_session # Disabilitazione protezione CSRF in caso di SOAP

  def users_service # Elaborazione dell'operazione SOAP
    request_body = request.body.read
    response_body = handle_soap_request(request_body)
    render xml: response_body, content_type: 'text/xml'
  end

  def wsdl # Elaborazione delle condizioni WSDL
    wsdl_path = Rails.root.join('app', 'services', 'wsdl', 'users_service.wsdl')
    render xml: File.read(wsdl_path), content_type: 'text/xml'
  end

  private

  def handle_soap_request(request) # Questo metodo è privato e gestisce il corpo della richiesta SOAP
    savon_request = parse_soap_request(request)
    action = savon_request[:action]

    # Invia un messaggio a Kafka per l'azione eseguita
    success_message = "SOAP action executed: #{action}, params: #{savon_request[:params]}"
    $kafka.deliver_message(success_message, topic: 'soap_users')

    case action
    when "FindUserById"
      user_id = savon_request[:params][:id]
      user = fetch_user_by_id(user_id) # Usa il metodo per gestire la cache
      build_response(user)
    when "FindUserByUsername"
      username = savon_request[:params][:username]
      user = fetch_user_by_username(username) # Usa il metodo per gestire la cache
      build_response(user)
    when "FindAllUsers"
      users = fetch_all_users # Usa il metodo per gestire la cache
      build_response(users)
    when "SearchUsersByName"
      name = savon_request[:params][:name]
      users = fetch_users_by_name(name) # Usa il metodo per gestire la cache
      build_response(users)
    when "OrderUsersBy"
      attribute = savon_request[:params][:attribute]
      direction = savon_request[:params][:direction]
      users = fetch_users_ordered_by(attribute, direction) # Usa il metodo per gestire la cache
      build_response(users)
    when "CreateUser"
      user_params = savon_request[:params][:user]
      result = @user_service.create_user(user_params)
      build_response(result)
    when "UpdateUser"
      user_params = savon_request[:params][:user]
      result = @user_service.update_user(user_params)
      build_response(result)
    when "DeleteUser"
      user_id = savon_request[:params][:id]
      result = @user_service.delete_user(user_id)
      build_response(result)
    else
      "<error>Unsupported action</error>"
    end
  end

  def fetch_user_by_id(user_id)
    local_cache_key = "soap/find_user_by_id/#{user_id}"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @user_service.find_user_by_id(user_id)
    end
  end

  def fetch_user_by_username(username)
    local_cache_key = "soap/find_user_by_username/#{username}"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @user_service.find_user_by_username(username)
    end
  end

  def fetch_all_users
    local_cache_key = "soap/find_all_users"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @user_service.find_all_users
    end
  end

  def fetch_users_by_name(name)
    local_cache_key = "soap/search_users_by_name/#{name}"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @user_service.search_users_by_name(name)
    end
  end

  def fetch_users_ordered_by(attribute, direction)
    local_cache_key = "soap/order_users_by/#{attribute}/#{direction}"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @user_service.order_users_by(attribute, direction)
    end
  end

  def parse_soap_request(request)
    doc = Nokogiri::XML(request) # Per analizzare le richieste XML
    action = doc.xpath('//Body/*').first.name # Ottieni il nome dell'azione
    params = {}

    case action
    when "CreateUser"
      params[:user] = {
        nome: doc.at_xpath('//user/nome').content,
        cognome: doc.at_xpath('//user/cognome').content,
        username: doc.at_xpath('//user/username').content,
        email: doc.at_xpath('//user/email').content,
        password_hash: doc.at_xpath('//user/password_hash').content,
        role: doc.at_xpath('//user/role').content,
        status: doc.at_xpath('//user/status').content,
        session_token: doc.at_xpath('//user/session_token').content,
        jwt_token: doc.at_xpath('//user/jwt_token').content,
        two_factor_enabled: doc.at_xpath('//user/two_factor_enabled').content,
        profile_picture: doc.at_xpath('//user/profile_picture').content
      }
    when "FindUserById"
      params[:id] = doc.at_xpath('//id').content
    when "FindUserByUsername"
      params[:username] = doc.at_xpath('//username').content
    when "UpdateUser"
      params[:user] = {
        user_id: doc.at_xpath('//user/user_id').content,
        nome: doc.at_xpath('//user/nome').content,
        cognome: doc.at_xpath('//user/cognome').content,
        username: doc.at_xpath('//user/username').content,
        email: doc.at_xpath('//user/email').content,
        password_hash: doc.at_xpath('//user/password_hash').content,
        role: doc.at_xpath('//user/role').content,
        status: doc.at_xpath('//user/status').content,
        session_token: doc.at_xpath('//user/session_token').content,
        jwt_token: doc.at_xpath('//user/jwt_token').content,
        two_factor_enabled: doc.at_xpath('//user/two_factor_enabled').content,
        profile_picture: doc.at_xpath('//user/profile_picture').content
      }
    when "DeleteUser"
      params[:id] = doc.at_xpath('//id').content
    when "FindAllUsers", "SearchUsersByName", "OrderUsersBy"
      # Aggiungi il supporto per questi metodi se necessario.
    end

    { action: action, params: params }
  end

  def build_response(data) # Response
    if data.is_a?(Hash) && data[:error]
      "<error>#{data[:error]}</error>"
    else
      # Genera una risposta XML in base ai dati ricevuti
      "<response>#{data.to_xml}</response>" # Assicurati che data sia un hash o un oggetto convertibile in XML
    end
  end
end
