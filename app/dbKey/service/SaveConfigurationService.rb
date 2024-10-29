# app/services/save_configuration_service.rb
class SaveConfigurationService
  def initialize(SaveConfigurationRepositoryImpl)
    @repository = SaveConfigurationRepositoryImpl
  end

  def get_all_configurations
    @repository.find_all
  end

  def get_configuration(id)
    @repository.find_by_id(id)
  end

  def create_configuration(attributes)
    configuration = SaveConfiguration.new(attributes)
    @repository.create(configuration)
  end

  def update_configuration(id, attributes)
    @repository.update(id, attributes)
  end

  def delete_configuration(id)
    @repository.delete(id)
  end
end
