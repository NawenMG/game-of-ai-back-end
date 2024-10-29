# app/models/cella.rb
class Cella
  include ArangoDB::Document # Assicurati di avere il supporto per ArangoDB
  include ActiveModel::Model # Include ActiveModel per le validazioni

  # Definizione della struttura del modello
  attr_accessor :key, :x, :y, :is_alive, :generation

  # Validazioni
  validates :key, presence: true, uniqueness: true
  validates :x, presence: true, numericality: { only_integer: true }
  validates :y, presence: true, numericality: { only_integer: true }
  validates :is_alive, inclusion: { in: [true, false] }
  validates :generation, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def initialize(key:, x:, y:, is_alive:, generation: 0)
    @key = key
    @x = x
    @y = y
    @is_alive = is_alive
    @generation = generation
  end


end
