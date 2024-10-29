# app/controllers/simulation_results_controller.rb
class SimulationResultsController < ApplicationController
  def initialize
    @repository = SimulationResultsRepository.new
    @service = SimulationResultsService.new(@repository)
  end

  # POST /simulation_results
  def create
    result_params = params.require(:simulation_result).permit(:user_id, :result_id, :simulation_name, :count, :grid_size, :initial_state, :final_state, :completed, :status, :media_url, :input_parameters, :ai_predictions)
    simulation_result = @service.create_result(result_params)

    # Invia un messaggio a Kafka per la creazione del risultato della simulazione
    success_message = "Simulation result created: #{simulation_result.to_json}"
    $kafka.deliver_message(success_message, topic: 'simulation_results_actions')

    render json: { message: 'Simulation result created successfully' }, status: :created
  end

  # PUT /simulation_results/:result_id
  def update
    result_params = params.require(:simulation_result).permit(:user_id, :simulation_name, :count, :grid_size, :initial_state, :final_state, :completed, :status, :media_url, :input_parameters, :ai_predictions)
    simulation_result = @service.update_result(params[:result_id], result_params)

    # Invia un messaggio a Kafka per l'aggiornamento del risultato della simulazione
    success_message = "Simulation result updated: #{simulation_result.to_json}"
    $kafka.deliver_message(success_message, topic: 'simulation_results_actions')

    render json: { message: 'Simulation result updated successfully' }
  end

  # DELETE /simulation_results/:result_id
  def destroy
    @service.delete_result(params[:result_id])

    # Invia un messaggio a Kafka per l'eliminazione del risultato della simulazione
    success_message = "Simulation result deleted with ID: #{params[:result_id]}"
    $kafka.deliver_message(success_message, topic: 'simulation_results_actions')

    render json: { message: 'Simulation result deleted successfully' }
  end
end
