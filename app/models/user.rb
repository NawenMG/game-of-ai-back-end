# app/models/user.rb
class User < ApplicationRecord
  self.table_name = "users"  # Usa il nome della tabella PostgreSQL

  # Imposta le colonne esistenti in `users` come attributi del model
  attr_accessor :user_id, :nome, :cognome, :username, :email, :password_hash,
                :role, :status, :session_token, :jwt_token,
                :two_factor_enabled, :profile_picture

  # Validazioni (opzionali, puoi personalizzarle)
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
