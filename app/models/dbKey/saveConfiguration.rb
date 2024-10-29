# app/models/save_configuration.rb
class SaveConfiguration
  include Google::Cloud::Datastore::Entity

  attr_accessor :id, :live_symbol, :dead_symbol, :live_color, :dead_color

  def initialize(attributes = {})
    @id = attributes[:id]
    @live_symbol = attributes[:live_symbol]
    @dead_symbol = attributes[:dead_symbol]
    @live_color = attributes[:live_color]
    @dead_color = attributes[:dead_color]
  end

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
