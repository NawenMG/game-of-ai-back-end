# app/models/relazione_celle.rb
class RelazioneCelle
  include Arango::Model

  # Definizione dei campi della collezione
  attribute :cell_id, String
  attribute :simulation_id, String
  attribute :relationship_type, String
  attribute :timestamp, Time

  #nome della collezione in arango
  collection :relazione_celle

  # Metodo per inizializzare un nuovo oggetto
  def initialize(attributes = {})
    super(attributes)
  end
end
