# app/repositories/simulation_results_repository.rb

class SimulationResultsRepositoryImplWithoutORM
  include SimulationResultsRepository

  ALLOWED_ORDER_COLUMNS = %w[simulation_name creation_date].freeze

  def initialize(connection)
    @connection = connection
  end

  # Trova tutti i risultati delle simulazioni, ordinati per data di creazione
  def find_all(order_by: 'creation_date', direction: 'desc')
    raise ArgumentError, 'Invalid order column' unless ALLOWED_ORDER_COLUMNS.include?(order_by)
    raise ArgumentError, 'Invalid direction' unless %w[asc desc].include?(direction)

    sql = "SELECT * FROM simulation_results ORDER BY #{order_by} #{direction}"
    result = @connection.exec_params(sql, [])
    result.map { |row| row }
  end

  # Trova i risultati per nome della simulazione con ricerca parziale
  def find_by_simulation_name(simulation_name)
    raise ArgumentError, "Invalid simulation name" if simulation_name.empty?

    sql = "SELECT * FROM simulation_results WHERE simulation_name ILIKE $1"
    result = @connection.exec_params(sql, ["%#{simulation_name}%"])
    result.to_a
  end

  # Crea un nuovo risultato della simulazione
  def create(attributes)
    validate_simulation_result(attributes)
    sql = <<-SQL
      INSERT INTO simulation_results
      (user_id, result_id, simulation_name, count, grid_size, initial_state, final_state, completed, status, creation_date, media_url, input_parameters, ai_predictions)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
    SQL
    @connection.exec_params(sql, attributes.values)
    { message: 'Simulation result created successfully' }
  end

  # Aggiorna un risultato della simulazione
  def update(result_id, attributes)
    raise ArgumentError, 'Invalid result ID' unless valid_id?(result_id)
    validate_simulation_result(attributes)

    sql = "UPDATE simulation_results SET #{attributes.keys.map.with_index { |k, i| "#{k} = $#{i + 1}" }.join(', ')} WHERE result_id = $#{attributes.size + 1}"
    @connection.exec_params(sql, attributes.values + [result_id])
    { message: 'Simulation result updated successfully' }
  end

  # Elimina un risultato della simulazione per ID
  def delete(result_id)
    raise ArgumentError, 'Invalid result ID' unless valid_id?(result_id)

    sql = "DELETE FROM simulation_results WHERE result_id = $1"
    result = @connection.exec_params(sql, [result_id])
    if result.cmd_tuples.positive?
      { message: 'Simulation result deleted successfully' }
    else
      { error: 'Failed to delete simulation result or result not found' }
    end
  end

  private

  def valid_id?(id)
    id.is_a?(Integer) && id.positive?
  end

  def validate_simulation_result(attributes)
    required_keys = %i[user_id result_id simulation_name count grid_size initial_state final_state completed status creation_date]
    missing_keys = required_keys - attributes.keys
    raise ArgumentError, "Missing required attributes: #{missing_keys.join(', ')}" unless missing_keys.empty?
  end
end
