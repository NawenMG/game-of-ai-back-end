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
  validates :comment, presence: true, length: { maximum: 500 } # Limita il commento a 500 caratteri
  validates :explanation, length: { maximum: 1000 }, allow_nil: true # Spiegazione facoltativa, limite a 1000 caratteri
  validates :timestamp, presence: true
  validate :timestamp_is_not_in_the_future # Validazione personalizzata

  private

  # Metodo di validazione personalizzato per controllare che il timestamp non sia nel futuro
  def timestamp_is_not_in_the_future
    if timestamp.present? && timestamp > Time.current
      errors.add(:timestamp, "non può essere una data futura.")
    end
  end
end
