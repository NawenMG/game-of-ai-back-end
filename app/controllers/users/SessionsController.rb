# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {}) # Login
    # Invia un messaggio a Kafka per il login riuscito
    success_message = "User logged in successfully: #{resource.to_json}"
    $kafka.deliver_message(success_message, topic: 'user_logins')

    render json: {
      message: 'Login effettuato con successo!',
      user: resource,
      jwt: current_token # Restituisce il token JWT
    }, status: :ok
  end

  def respond_to_on_destroy # Logout
    # Invia un messaggio a Kafka per il logout
    logout_message = "User logged out: #{current_user&.to_json || 'Unknown user'}"
    $kafka.deliver_message(logout_message, topic: 'user_logouts')

    render json: { message: 'Logout effettuato con successo!' }, status: :ok
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
