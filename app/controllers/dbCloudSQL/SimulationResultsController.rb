# app/controllers/simulation_results_controller.rb
class SimulationResultsController < ApplicationController
  def initialize
    @repository = SimulationResultsRepository
    @service = SimulationResultsService.new(@repository)
  end

  # POST /simulation_results
  def create
    result_params = params.require(:simulation_result).permit(:user_id, :result_id, :simulation_name, :count, :grid_size, :initial_state, :final_state, :completed, :status, :media_url, :input_parameters, :ai_predictions)
    @service.create_result(result_params)
    render json: { message: 'Simulation result created successfully' }, status: :created
  end

  # PUT /simulation_results/:result_id
  def update
    result_params = params.require(:simulation_result).permit(:user_id, :simulation_name, :count, :grid_size, :initial_state, :final_state, :completed, :status, :media_url, :input_parameters, :ai_predictions)
    @service.update_result(params[:result_id], result_params)
    render json: { message: 'Simulation result updated successfully' }
  end

  # DELETE /simulation_results/:result_id
  def destroy
    @service.delete_result(params[:result_id])
    render json: { message: 'Simulation result deleted successfully' }
  end
end
