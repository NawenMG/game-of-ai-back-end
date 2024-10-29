# app/repositories/simulation_results_repository.rb

module SimulationResultsRepository
  def find_all
    raise NotImplementedError
  end

  def find_by_simulation_name(simulation_name)
    raise NotImplementedError
  end

  def create(attributes)
    raise NotImplementedError
  end

  def update(result_id, attributes)
    raise NotImplementedError
  end

  def delete(result_id)
    raise NotImplementedError
  end
end
