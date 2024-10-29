# app/controllers/simulation_streaming_controller.rb
class SimulationStreamingController < ApplicationController
  def initialize
    @service = SimulationStreamingService.new
  end

  # GET: Stream delle simulazioni
  def stream_simulations
    simulations = fetch_all_simulations
    ActionCable.server.broadcast("simulation_streaming_channel", simulations: simulations)

    success_message = "Streaming all simulations"
    $kafka.deliver_message(success_message, topic: 'simulation_streaming')

    render json: { status: 'streaming simulations' }
  end

  # POST: Creazione di una nuova simulazione
  def create
    simulation = @service.create_simulation(simulation_params)
    ActionCable.server.broadcast("simulation_streaming_channel", action: "created", simulation: simulation)

    success_message = "Simulation created: #{simulation.to_json}"
    $kafka.deliver_message(success_message, topic: 'simulation_streaming')

    render json: simulation
  end

  # PUT: Aggiornamento di una simulazione
  def update
    @service.update_simulation(params[:id], simulation_params)
    simulation = fetch_simulation(params[:id])
    ActionCable.server.broadcast("simulation_streaming_channel", action: "updated", simulation: simulation)

    success_message = "Simulation updated: #{simulation.to_json}"
    $kafka.deliver_message(success_message, topic: 'simulation_streaming')

    render json: simulation
  end

  # DELETE: Eliminazione di una simulazione
  def destroy
    @service.delete_simulation(params[:id])
    ActionCable.server.broadcast("simulation_streaming_channel", action: "deleted", simulation_id: params[:id])

    success_message = "Simulation deleted: #{params[:id]}"
    $kafka.deliver_message(success_message, topic: 'simulation_streaming')

    render json: { message: 'Simulation deleted' }
  end

  private

  def fetch_all_simulations
    local_cache_key = "simulation_streaming/all_simulations"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @service.get_all_simulations
    end
  end

  def fetch_simulation(id)
    local_cache_key = "simulation_streaming/simulation/#{id}"
    Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      @service.find_simulation(id)
    end
  end

  def simulation_params
    params.permit(:simulation_id, :user_id, :generation_number, :grid_state, :timestamp)
  end
end
