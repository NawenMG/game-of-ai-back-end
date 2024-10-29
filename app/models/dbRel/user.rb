# app/models/user.rb
class User < ApplicationRecord
  # Includi i moduli di Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # Sicurezza per la password
  has_secure_password

  # Validazioni
  validates :nome, presence: true
  validates :cognome, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { in: 6..128 }, if: -> { password.present? }
  validates :auth_token, uniqueness: true, allow_nil: true

  # Callback per generare un token di autenticazione sicuro
  before_create :generate_auth_token

  # Metodo per generare un token di autenticazione sicuro
  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex(10)
    end while self.class.exists?(auth_token: auth_token)
  end

  # Metodo per l'attivazione del 2FA
  def enable_two_factor!
    self.two_factor_enabled = true
    self.two_factor_secret = ROTP::Base32.random_base32
    save!
  end

  # Metodo per generare il codice TOTP (Time-Based One-Time Password)
  def current_otp
    ROTP::TOTP.new(two_factor_secret).now
  end

  # Metodo di verifica del codice TOTP
  def verify_otp(code)
    ROTP::TOTP.new(two_factor_secret).verify(code)
  end

  # Metodo per la rappresentazione JSON sicura dell'utente
  def to_hash
    {
      id: id,
      nome: nome,
      cognome: cognome,
      username: username,
      email: email,
      role: role,
      status: status,
      profile_picture: profile_picture,
      two_factor_enabled: two_factor_enabled
    }
  end
end
