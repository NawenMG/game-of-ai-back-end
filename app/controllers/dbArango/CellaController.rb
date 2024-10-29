# app/controllers/cella_controller.rb
class CellaController < ApplicationController
  def create
    cella_service = CellaService.new
    cella = cella_service.create_cell(cella_params)

    if cella
      # Invia un messaggio a Kafka per la creazione della cella
      success_message = "Cella created: #{cella.to_json}"
      $kafka.deliver_message(success_message, topic: 'cella_actions')

      render json: cella, status: :created
    else
      render json: { error: 'Errore nella creazione della cella' }, status: :unprocessable_entity
    end
  end

  def update
    cella_service = CellaService.new
    cella = cella_service.update_cell(params[:id], cella_params)

    if cella
      # Invia un messaggio a Kafka per l'aggiornamento della cella
      success_message = "Cella updated: #{cella.to_json}"
      $kafka.deliver_message(success_message, topic: 'cella_actions')

      render json: cella, status: :ok
    else
      render json: { error: 'Cella non trovata' }, status: :not_found
    end
  end

  def destroy
    cella_service = CellaService.new
    if cella_service.delete_cell(params[:id])
      # Invia un messaggio a Kafka per l'eliminazione della cella
      success_message = "Cella deleted with ID: #{params[:id]}"
      $kafka.deliver_message(success_message, topic: 'cella_actions')

      head :no_content
    else
      render json: { error: 'Cella non trovata' }, status: :not_found
    end
  end

  private

  def cella_params
    params.require(:cella).permit(:key, :x, :y, :is_alive, :generation)
  end
end
