# app/models/performance_monitoring.rb
class PerformanceMonitoring
  include InfluxDB::Rails::Model
  
  # Mappa le colonne del modello
  attribute :measurement, String
  attribute :simulation_id, String
  attribute :generation_number, Integer
  attribute :execution_time, Float
  attribute :live_cells, Integer
  attribute :dead_cells, Integer
  attribute :timestamp, Integer # UNIX timestamp in nanosecondi

  # La configurazione dell'InfluxDB
  self.influxdb_database = 'mydatabase'
  self.influxdb_client = InfluxDB::Client.new(
    host: 'localhost',
    port: 8086,
    username: 'myuser',
    password: 'mypassword'
  )
end
