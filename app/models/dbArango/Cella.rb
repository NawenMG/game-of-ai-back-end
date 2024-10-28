# app/models/cella.rb
class Cella
  include ArangoDB::Document # Assicurati di avere il supporto per ArangoDB

  # Definizione della struttura del modello
  attr_accessor :key, :x, :y, :is_alive, :generation

  def initialize(key:, x:, y:, is_alive:, generation:)
    @key = key
    @x = x
    @y = y
    @is_alive = is_alive
    @generation = generation
  end
end
