# app/graphql/types/performance_monitoring_type.rb
module Types
  class PerformanceMonitoringType < BaseObject
    field :measurement, String, null: false
    field :simulation_id, String, null: false
    field :generation_number, Integer, null: false
    field :execution_time, Float, null: false
    field :live_cells, Integer, null: false
    field :dead_cells, Integer, null: false
    field :timestamp, Integer, null: false # UNIX timestamp in nanosecondi
  end
end
