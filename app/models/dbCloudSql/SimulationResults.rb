# app/models/simulation_results.rb
class SimulationResults < ApplicationRecord
  self.table_name = 'simulation_results'

  validates :user_id, presence: true
  validates :result_id, presence: true
  validates :simulation_name, presence: true
  validates :count, presence: true
  validates :grid_size, presence: true
  validates :initial_state, presence: true
  validates :final_state, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :status, presence: true
  validates :creation_date, presence: true
  validates :media_url, presence: true
  validates :input_parameters, presence: true
  validates :ai_predictions, presence: true
end
