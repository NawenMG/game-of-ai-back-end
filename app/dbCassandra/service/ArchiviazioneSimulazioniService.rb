class ArchiviazioneSimulazioniService
  def initialize
    @repository = ArchiviazioneSimulazioniRepositoryImpl.new
  end

  def get_all
    @repository.get_all
  end

  def find_by_user_id(user_id)
    @repository.find_by_user_id(user_id)
  end

  def search_by_grid_state(grid_state)
    @repository.search_by_grid_state(grid_state)
  end

  def create(attributes)
    @repository.create(attributes)
  end

  def update(user_id, simulation_id, attributes)
    @repository.update(user_id, simulation_id, attributes)
  end

  def delete(user_id, simulation_id)
    @repository.delete(user_id, simulation_id)
  end
end
