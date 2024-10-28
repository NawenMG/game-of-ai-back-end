# app/models/simulation_streaming.rb
class SimulationStreaming
  attr_accessor :id, :simulation_id, :user_id, :generation_number, :grid_state, :timestamp

  def initialize(attributes = {})
    @id = attributes[:id]
    @simulation_id = attributes[:simulation_id]
    @user_id = attributes[:user_id]
    @generation_number = attributes[:generation_number]
    @grid_state = attributes[:grid_state]
    @timestamp = attributes[:timestamp]
  end
end
