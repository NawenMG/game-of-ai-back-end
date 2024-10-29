# app/controllers/relazione_celle_controller.rb
class RelazioneCelleController < ApplicationController

  def create
    service = RelazioneCelleService.new
    @relazione = service.create(relazione_params)

    if @relazione
      # Invia un messaggio a Kafka per la creazione della relazione
      success_message = "Relazione creata: #{@relazione.to_json}"
      $kafka.deliver_message(success_message, topic: 'relazione_celle_actions')

      render json: @relazione, status: :created
    else
      render json: { error: 'Errore nella creazione della relazione' }, status: :unprocessable_entity
    end
  end

  def update
    service = RelazioneCelleService.new
    @relazione = service.update(params[:id], relazione_params)

    if @relazione
      # Invia un messaggio a Kafka per l'aggiornamento della relazione
      success_message = "Relazione aggiornata: #{@relazione.to_json}"
      $kafka.deliver_message(success_message, topic: 'relazione_celle_actions')

      render json: @relazione, status: :ok
    else
      render json: { error: 'Relazione non trovata' }, status: :not_found
    end
  end

  def destroy
    service = RelazioneCelleService.new
    if service.delete(params[:id])
      # Invia un messaggio a Kafka per l'eliminazione della relazione
      success_message = "Relazione eliminata con ID: #{params[:id]}"
      $kafka.deliver_message(success_message, topic: 'relazione_celle_actions')

      head :no_content
    else
      render json: { error: 'Relazione non trovata' }, status: :not_found
    end
  end

  private

  def relazione_params
    params.require(:relazione_celle).permit(:cell_id, :simulation_id, :relationship_type, :timestamp)
  end
end
