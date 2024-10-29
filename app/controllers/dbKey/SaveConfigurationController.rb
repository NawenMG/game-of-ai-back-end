# app/controllers/save_configurations_controller.rb
class SaveConfigurationsController < ApplicationController
  def initialize
    @repository = SaveConfigurationRepositoryImpl.new
    @service = SaveConfigurationService.new(@repository)
  end

  # POST /save_configurations
  def create
    config_params = params.require(:save_configuration).permit(:id, :live_symbol, :dead_symbol, :live_color, :dead_color)
    @service.create_configuration(config_params)
    render json: { message: 'Configuration created successfully' }, status: :created
  end

  # PUT /save_configurations/:id
  def update
    config_params = params.require(:save_configuration).permit(:live_symbol, :dead_symbol, :live_color, :dead_color)
    @service.update_configuration(params[:id], config_params)
    render json: { message: 'Configuration updated successfully' }
  end

  # DELETE /save_configurations/:id
  def destroy
    @service.delete_configuration(params[:id])
    render json: { message: 'Configuration deleted successfully' }
  end
end
