# app/controllers/two_factor_controller.rb
class TwoFactorController < ApplicationController
  before_action :authenticate_user!

  def verify
    if current_user.verify_otp(params[:otp_code]) # Verifica del codice OTP
      # Invia un messaggio a Kafka per il successo dell'autenticazione a due fattori
      success_message = "Two-factor authentication succeeded for user: #{current_user.id}"
      $kafka.deliver_message(success_message, topic: 'two_factor_auth_success')

      render json: { message: 'Autenticazione a due fattori completata con successo!' }, status: :ok
    else
      # Invia un messaggio a Kafka per il fallimento dell'autenticazione a due fattori
      failure_message = "Two-factor authentication failed for user: #{current_user.id}"
      $kafka.deliver_message(failure_message, topic: 'two_factor_auth_failure')

      render json: { error: 'Codice OTP non valido' }, status: :unauthorized
    end
  end
end
