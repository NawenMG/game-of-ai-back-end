# app/models/simulation_results.rb
class SimulationResults < ApplicationRecord
  self.table_name = 'simulation_results'

  # Validazioni
  validates :user_id, presence: true
  validates :result_id, presence: true, uniqueness: true # Assicurati che `result_id` sia unico
  validates :simulation_name, presence: true
  validates :count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 } # Deve essere un intero non negativo
  validates :grid_size, presence: true, numericality: { only_integer: true, greater_than: 0 } # Deve essere un intero positivo
  validates :initial_state, presence: true
  validates :final_state, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :status, presence: true, inclusion: { in: %w[pending running completed failed] } # Limita i valori di stato
  validates :creation_date, presence: true
  validates :media_url, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" } # Validazione dell'URL
  validates :input_parameters, presence: true
  validates :ai_predictions, presence: true

end
