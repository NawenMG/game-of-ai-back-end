# app/controllers/two_factor_controller.rb
class TwoFactorController < ApplicationController
  before_action :authenticate_user!

  def verify
    if current_user.verify_otp(params[:otp_code]) #Verifica del codice OTP
      render json: { message: 'Autenticazione a due fattori completata con successo!' }, status: :ok
    else
      render json: { error: 'Codice OTP non valido' }, status: :unauthorized
    end
  end
end
