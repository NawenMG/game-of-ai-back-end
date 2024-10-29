# app/controllers/save_configurations_controller.rb
class SaveConfigurationsController < ApplicationController
  def initialize
    @repository = SaveConfigurationRepositoryImpl.new
    @service = SaveConfigurationService.new(@repository)
  end

  # POST /save_configurations
  def create
    config_params = params.require(:save_configuration).permit(:id, :live_symbol, :dead_symbol, :live_color, :dead_color)
    saved_configuration = @service.create_configuration(config_params)

    # Invia un messaggio a Kafka per la creazione della configurazione
    success_message = "Configuration created: #{saved_configuration.to_json}"
    $kafka.deliver_message(success_message, topic: 'save_configurations_actions')

    render json: { message: 'Configuration created successfully' }, status: :created
  end

  # PUT /save_configurations/:id
  def update
    config_params = params.require(:save_configuration).permit(:live_symbol, :dead_symbol, :live_color, :dead_color)
    updated_configuration = @service.update_configuration(params[:id], config_params)

    # Invia un messaggio a Kafka per l'aggiornamento della configurazione
    success_message = "Configuration updated: #{updated_configuration.to_json}"
    $kafka.deliver_message(success_message, topic: 'save_configurations_actions')

    render json: { message: 'Configuration updated successfully' }
  end

  # DELETE /save_configurations/:id
  def destroy
    @service.delete_configuration(params[:id])

    # Invia un messaggio a Kafka per l'eliminazione della configurazione
    success_message = "Configuration deleted with ID: #{params[:id]}"
    $kafka.deliver_message(success_message, topic: 'save_configurations_actions')

    render json: { message: 'Configuration deleted successfully' }
  end
end
