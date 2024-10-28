class CellaController < ApplicationController
  def create
    cella_service = CellaService.new
    cella = cella_service.create_cell(cella_params)
    
    render json: cella, status: :created
  end

  def update
    cella_service = CellaService.new
    cella = cella_service.update_cell(params[:id], cella_params)

    if cella
      render json: cella, status: :ok
    else
      render json: { error: 'Cella non trovata' }, status: :not_found
    end
  end

  def destroy
    cella_service = CellaService.new
    if cella_service.delete_cell(params[:id])
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
