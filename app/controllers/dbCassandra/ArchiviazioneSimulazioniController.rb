# app/controllers/archiviazione_simulazioni_controller.rb
class ArchiviazioneSimulazioniController < ApplicationController
  def initialize
    @repository = ArchiviazioneSimulazioniRepository.new
    @service = ArchiviazioneSimulazioniService.new(@repository)
  end

  # POST /archiviazione_simulazioni
  def create
    simulazione_params = params.require(:archiviazione_simulazione).permit(:user_id, :simulation_id, :generation, :grid_state)
    simulazione = @service.create(simulazione_params)

    # Invia un messaggio a Kafka per la creazione della simulazione
    success_message = "Simulazione creata: #{simulazione.to_json}"
    $kafka.deliver_message(success_message, topic: 'archiviazione_simulazioni_actions')

    render json: { message: 'Simulazione creata con successo' }, status: :created
  end

  # PUT /archiviazione_simulazioni/:user_id/:simulation_id
  def update
    simulazione_params = params.require(:archiviazione_simulazione).permit(:generation, :grid_state)
    simulazione = @service.update(params[:user_id], params[:simulation_id], simulazione_params)

    # Invia un messaggio a Kafka per l'aggiornamento della simulazione
    success_message = "Simulazione aggiornata: #{simulazione.to_json}"
    $kafka.deliver_message(success_message, topic: 'archiviazione_simulazioni_actions')

    render json: { message: 'Simulazione aggiornata con successo' }
  end

  # DELETE /archiviazione_simulazioni/:user_id/:simulation_id
  def destroy
    @service.delete(params[:user_id], params[:simulation_id])

    # Invia un messaggio a Kafka per l'eliminazione della simulazione
    success_message = "Simulazione eliminata con ID: #{params[:simulation_id]}"
    $kafka.deliver_message(success_message, topic: 'archiviazione_simulazioni_actions')

    render json: { message: 'Simulazione eliminata con successo' }
  end

  # GET /archiviazione_simulazioni/order
  def order
    simulations = @repository.get_all
    render json: simulations
  end
end
