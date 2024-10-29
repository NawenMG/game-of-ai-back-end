# app/repositories/simulation_results_repository.rb

class SimulationResultsRepositoryImplORM
  include SimulationResultsRepository

  def find_all
    SimulationResult.order(creation_date: :desc).all
  end

  def find_by_simulation_name(simulation_name)
    SimulationResult.where(simulation_name: simulation_name).all
  end

  def create(attributes)
    SimulationResult.create(attributes)
  end

  def update(result_id, attributes)
    result = SimulationResult.find_by(result_id: result_id)
    return unless result

    result.update(attributes)
  end

  def delete(result_id)
    result = SimulationResult.find_by(result_id: result_id)
    result&.destroy
  end
end
