Devise.setup do |config|
  config.mailer_sender = 'inserisciemail@gmail.it'

  require 'devise/orm/mongoid'

  config.case_insensitive_keys = [:email] #Rendiamo case sensitive l'email

  config.strip_whitespace_keys = [:email] #Eliminazione di eventuali spazi bianchi

  config.skip_session_storage = [:http_auth] #Evita di salvare le sessioni in http auth

  config.stretches = Rails.env.test? ? 1 : 12 #Crittografia della password

  config.reconfirmable = true #In caso di cambiamento dell'email si deve avere una riconferma

  config.expire_all_remember_me_on_sign_out = true #Cancella i "rember me" con il logout

  config.password_length = 10..128 #Lunghezza minima e massima della password

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/ #Validazione del formato dell'email

  config.reset_password_within = 6.hours #Validità  temporale del token

  config.sign_out_via = :delete #Metodo per il logout

  config.responder.error_status = :unprocessable_entity  #Codice per gli errori
  config.responder.redirect_status = :see_other #Codice per il redirect

   # Configurazione jwt con la chiave segreta dell'app Rails
   config.jwt do |jwt|
    jwt.secret = OpenSSL::PKey::RSA.new(Rails.application.credentials[:devise_jwt_private_key])
    jwt.public_key = OpenSSL::PKey::RSA.new(Rails.application.credentials[:devise_jwt_public_key])    
    jwt.dispatch_requests = [ #Login
      ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [ #Logout
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 6.hours.to_i

    jwt.algorithm = 'PS512' 

  end
end
