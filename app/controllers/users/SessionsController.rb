# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {}) #Login
    render json: {
      message: 'Login effettuato con successo!',
      user: resource,
      jwt: current_token # Restituisce il token JWT
    }, status: :ok
  end

  def respond_to_on_destroy #Logout
    render json: { message: 'Logout effettuato con successo!' }, status: :ok
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
