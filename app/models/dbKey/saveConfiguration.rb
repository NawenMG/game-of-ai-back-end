# app/models/save_configuration.rb
class SaveConfiguration
  include Google::Cloud::Datastore::Entity
  include ActiveModel::Model # Include ActiveModel per le validazioni

  attr_accessor :id, :live_symbol, :dead_symbol, :live_color, :dead_color

  def initialize(attributes = {})
    @id = attributes[:id]
    @live_symbol = attributes[:live_symbol]
    @dead_symbol = attributes[:dead_symbol]
    @live_color = attributes[:live_color]
    @dead_color = attributes[:dead_color]
  end

  # Validazioni
  validates :id, presence: true # Assicurati che l'ID sia presente
  validates :live_symbol, presence: true, length: { maximum: 1 } # Limitato a 1 carattere
  validates :dead_symbol, presence: true, length: { maximum: 1 } # Limitato a 1 carattere
  validates :live_color, presence: true, format: { with: /\A#[0-9a-fA-F]{6}\z/, message: "must be a valid hex color code" } # Validazione colore esadecimale
  validates :dead_color, presence: true, format: { with: /\A#[0-9a-fA-F]{6}\z/, message: "must be a valid hex color code" } # Validazione colore esadecimale

  def to_entity
    entity = Google::Cloud::Datastore::Entity.new
    entity.key = Google::Cloud::Datastore::Key.new('SaveConfiguration', @id)
    entity['live_symbol'] = @live_symbol
    entity['dead_symbol'] = @dead_symbol
    entity['live_color'] = @live_color
    entity['dead_color'] = @dead_color
    entity
  end
end
