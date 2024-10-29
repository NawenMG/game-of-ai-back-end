# app/services/simulation_results_service.rb
class SimulationResultsService
  def initialize(SimulationResultsRepositoryImplWithoutORM)
    @repository = SimulationResultsRepositoryImplWithoutORM
  end

  def get_all_results
    @repository.get_all
  end

  def find_result_by_name(simulation_name)
    @repository.find_by_simulation_name(simulation_name)
  end

  def create_result(attributes)
    @repository.create(attributes)
  end

  def update_result(result_id, attributes)
    @repository.update(result_id, attributes)
  end

  def delete_result(result_id)
    @repository.delete(result_id)
  end
end
