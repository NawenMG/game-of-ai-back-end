# app/models/user.rb

class User < ApplicationRecord
  # Validazioni
  validates :nome, presence: true
  validates :cognome, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_hash, presence: true

  # Puoi aggiungere metodi personalizzati qui
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

  # Esempio di metodo per cercare utenti
  def self.search_by_name(name)
    where('nome LIKE ? OR cognome LIKE ?', "%#{name}%", "%#{name}%")
  end
end
