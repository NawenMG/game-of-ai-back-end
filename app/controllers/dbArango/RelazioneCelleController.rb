# app/controllers/relazione_celle_controller.rb
class RelazioneCelleController < ApplicationController

  def create
    service = RelazioneCelleService.new
    @relazione = service.create(relazione_params)
    render json: @relazione, status: :created
  end

  def update
    service = RelazioneCelleService.new
    @relazione = service.update(params[:id], relazione_params)
    render json: @relazione
  end

  def destroy
    service = RelazioneCelleService.new
    service.delete(params[:id])
    head :no_content
  end

  private

  def relazione_params
    params.require(:relazione_celle).permit(:cell_id, :simulation_id, :relationship_type, :timestamp)
  end
end
