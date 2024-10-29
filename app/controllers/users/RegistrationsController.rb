# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      # Invia un messaggio a Kafka per la registrazione riuscita
      success_message = "User registered successfully: #{resource.to_json}"
      $kafka.deliver_message(success_message, topic: 'user_registrations')

      render json: {
        message: 'Registrazione completata con successo!',
        user: resource,
        jwt: current_token
      }, status: :ok
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
