# app/models/relation_cella.rb
class RelazioneCella
  include ArangoDB::Document # Assicurati di avere il supporto per ArangoDB
  include ActiveModel::Model # Include ActiveModel per le validazioni

  # Definizione della struttura del modello
  attr_accessor :from, :to, :relationship

  # Validazioni
  validates :from, presence: true
  validates :to, presence: true
  validates :relationship, presence: true, inclusion: { in: %w[friend enemy neutral] }

  def initialize(from:, to:, relationship:)
    @from = from
    @to = to
    @relationship = relationship
  end

end
