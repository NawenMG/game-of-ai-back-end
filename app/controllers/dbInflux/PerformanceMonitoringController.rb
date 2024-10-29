# app/controllers/performance_monitorings_controller.rb
class PerformanceMonitoringsController < ApplicationController

  def create
    service = PerformanceMonitoringService.new
    performance = service.create(performance_params)

    # Invia un messaggio a Kafka per la creazione della registrazione delle prestazioni
    success_message = "Performance monitoring created: #{performance.to_json}"
    $kafka.deliver_message(success_message, topic: 'performance_monitorings_actions')

    render json: performance, status: :created
  end

  def update
    service = PerformanceMonitoringService.new
    performance = service.update(params[:id], performance_params)

    # Invia un messaggio a Kafka per l'aggiornamento della registrazione delle prestazioni
    success_message = "Performance monitoring updated: #{performance.to_json}"
    $kafka.deliver_message(success_message, topic: 'performance_monitorings_actions')

    render json: performance, status: :ok
  end

  def destroy
    service = PerformanceMonitoringService.new
    service.delete(params[:id])

    # Invia un messaggio a Kafka per l'eliminazione della registrazione delle prestazioni
    success_message = "Performance monitoring deleted with ID: #{params[:id]}"
    $kafka.deliver_message(success_message, topic: 'performance_monitorings_actions')

    head :no_content
  end

  private

  def performance_params
    params.require(:performance_monitoring).permit(:measurement, :simulation_id, :generation_number, :execution_time, :live_cells, :dead_cells, :timestamp)
  end
end
