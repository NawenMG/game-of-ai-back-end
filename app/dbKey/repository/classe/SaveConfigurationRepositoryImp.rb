# app/repositories/save_configuration_repository_impl.rb
class SaveConfigurationRepositoryImpl
  include SaveConfigurationRepository

  def initialize
    @datastore = Google::Cloud::Datastore.new
  end

  def find_all
    query = @datastore.query('SaveConfiguration')
    @datastore.run(query).map { |entity| SaveConfiguration.new(entity.to_h) }
  end

  def find_by_id(id)
    entity = @datastore.find("SaveConfiguration", id)
    entity ? SaveConfiguration.new(entity.to_h) : nil
  end

  def create(save_configuration)
    entity = save_configuration.to_entity
    @datastore.save(entity)
  end

  def update(id, attributes)
    entity = @datastore.find("SaveConfiguration", id)
    return unless entity

    attributes.each do |key, value|
      entity[key] = value
    end

    @datastore.save(entity)
  end

  def delete(id)
    @datastore.delete("SaveConfiguration", id)
  end
end
