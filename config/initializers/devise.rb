Devise.setup do |config|
  # Imposta il mittente delle email
  config.mailer_sender = 'noreply@tuodominio.com'

  # Configurazione dell'ORM (Mongoid)
  require 'devise/orm/mongoid'

  # Configurazione per le chiavi case insensitive
  config.case_insensitive_keys = [:email]

  # Rimuove spazi bianchi dall'email
  config.strip_whitespace_keys = [:email]

  # Salta la sessione http_auth
  config.skip_session_storage = [:http_auth]

  # Imposta il numero di "stretch" per la crittografia della password
  config.stretches = Rails.env.test? ? 1 : 12

  # Riconferma necessaria per il cambio email
  config.reconfirmable = true

  # Elimina il "remember me" al logout
  config.expire_all_remember_me_on_sign_out = true

  # Lunghezza minima e massima per le password
  config.password_length = 8..128

  # Regex per la validazione dell'email
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Validità del token per il reset della password
  config.reset_password_within = 6.hours

  # Metodo per il logout
  config.sign_out_via = :delete

  # Configurazione dei JWT
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret || 's3cret' # Imposta una chiave segreta
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}],
      ['POST', %r{^/users/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}],
      ['DELETE', %r{^/users/sign_out$}]
    ]
    jwt.expiration_time = 6.hours.to_i
    jwt.algorithm = 'HS256' # Puoi cambiare in PS512 se hai bisogno di una firma RSA
  end
end
