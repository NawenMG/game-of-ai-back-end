# app/services/simulation_streaming_service.rb
class SimulationStreamingService
  def initialize
    @repository = SimulationStreamingRepository.new
  end

  def get_all_simulations
    @repository.get_all
  end

  def find_simulation(id)
    @repository.find_by_id(id)
  end

  def create_simulation(attributes)
    simulation = SimulationStreaming.new(attributes)
    @repository.create(simulation)
  end

  def update_simulation(id, attributes)
    @repository.update(id, attributes)
  end

  def delete_simulation(id)
    @repository.delete(id)
  end
end
