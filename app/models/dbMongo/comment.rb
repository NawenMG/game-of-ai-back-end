class Comment
  include Mongoid::Document
  include Mongoid::Timestamps # Aggiunge created_at e updated_at automaticamente

  # Definizione dei campi della collezione
  field :simulation_id, type: BSON::ObjectId
  field :user_id, type: String
  field :comment, type: String
  field :explanation, type: String
  field :timestamp, type: Time # ISODate è mappato su Time in Ruby

  # Validazioni
  validates :simulation_id, presence: true
  validates :user_id, presence: true
  validates :comment, presence: true
  validates :timestamp, presence: true
end
