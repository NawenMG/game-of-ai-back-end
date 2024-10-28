# app/controllers/performance_monitorings_controller.rb
class PerformanceMonitoringsController < ApplicationController

  def create
    service = PerformanceMonitoringService.new
    performance = service.create(performance_params)
    render json: performance, status: :created
  end

  def update
    service = PerformanceMonitoringService.new
    performance = service.update(params[:id], performance_params)
    render json: performance, status: :ok
  end

  def destroy
    service = PerformanceMonitoringService.new
    service.delete(params[:id])
    head :no_content
  end

  private

  def performance_params
    params.require(:performance_monitoring).permit(:measurement, :simulation_id, :generation_number, :execution_time, :live_cells, :dead_cells, :timestamp)
  end
end
