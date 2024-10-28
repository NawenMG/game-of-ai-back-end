# app/models/relation_cella.rb
class RelazioneCella
  include ArangoDB::Document # Assicurati di avere il supporto per ArangoDB

  # Definizione della struttura del modello
  attr_accessor :from, :to, :relationship

  def initialize(from:, to:, relationship:)
    @from = from
    @to = to
    @relationship = relationship
  end
end
