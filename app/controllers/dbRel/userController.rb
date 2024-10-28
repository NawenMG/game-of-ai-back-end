class UsersSoapController < ApplicationController
  protect_from_forgery with: :null_session #Disabilitazione protezione csrf in caso di soap

  def users_service #Elaborazione dell'operazione soap
    request_body = request.body.read
    response_body = handle_soap_request(request_body)
    render xml: response_body, content_type: 'text/xml'
  end

  def wsdl #Elaborazione delle condizioni wsdl
    wsdl_path = Rails.root.join('app', 'services', 'wsdl', 'users_service.wsdl')
    render xml: File.read(wsdl_path), content_type: 'text/xml'
  end

  private

  def handle_soap_request(request) #Questo metodo è privato e gestisce il corpo della richiesta SOAP. Chiama parse_soap_request per convertire il contenuto XML in un formato più utilizzabile
    savon_request = parse_soap_request(request)

    case savon_request[:action]
    when "FindUserById"
      user_id = savon_request[:params][:id]
      user = @user_service.find_user_by_id(user_id)
      build_response(user)
    when "FindUserByUsername"
      username = savon_request[:params][:username]
      user = @user_service.find_user_by_username(username)
      build_response(user)
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
    when "FindAllUsers"
      users = @user_service.find_all_users
      build_response(users)
    when "SearchUsersByName"
      name = savon_request[:params][:name]
      users = @user_service.search_users_by_name(name)
      build_response(users)
    when "OrderUsersBy"
      attribute = savon_request[:params][:attribute]
      direction = savon_request[:params][:direction]
      users = @user_service.order_users_by(attribute, direction)
      build_response(users)
    else
      "<error>Unsupported action</error>"
    end
  end

  def parse_soap_request(request)
    doc = Nokogiri::XML(request) #Per analizzare le richieste xml
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

  def build_response(data) #Response
    if data.is_a?(Hash) && data[:error]
      "<error>#{data[:error]}</error>"
    else
      # Genera una risposta XML in base ai dati ricevuti
      "<response>#{data.to_xml}</response>" # Assicurati che data sia un hash o un oggetto convertibile in XML
    end
  end
end
