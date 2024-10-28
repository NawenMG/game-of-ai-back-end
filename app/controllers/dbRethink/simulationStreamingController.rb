# app/controllers/simulation_streaming_controller.rb
class SimulationStreamingController < ApplicationController
  def initialize
    @service = SimulationStreamingService.new
  end

  # GET: Stream delle simulazioni
  def stream_simulations
    simulations = @service.get_all_simulations
    ActionCable.server.broadcast("simulation_streaming_channel", simulations: simulations)
    render json: { status: 'streaming simulations' }
  end

  # POST: Creazione di una nuova simulazione
  def create
    simulation = @service.create_simulation(simulation_params)
    ActionCable.server.broadcast("simulation_streaming_channel", action: "created", simulation: simulation)
    render json: simulation
  end

  # PUT: Aggiornamento di una simulazione
  def update
    @service.update_simulation(params[:id], simulation_params)
    simulation = @service.find_simulation(params[:id])
    ActionCable.server.broadcast("simulation_streaming_channel", action: "updated", simulation: simulation)
    render json: simulation
  end

  # DELETE: Eliminazione di una simulazione
  def destroy
    @service.delete_simulation(params[:id])
    ActionCable.server.broadcast("simulation_streaming_channel", action: "deleted", simulation_id: params[:id])
    render json: { message: 'Simulation deleted' }
  end

  private

  def simulation_params
    params.permit(:simulation_id, :user_id, :generation_number, :grid_state, :timestamp)
  end
end
