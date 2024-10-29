# app/models/performance_monitoring.rb
class PerformanceMonitoring
  include InfluxDB::Rails::Model
  include ActiveModel::Model # Include ActiveModel per le validazioni

  # Mappa le colonne del modello
  attribute :measurement, String
  attribute :simulation_id, String
  attribute :generation_number, Integer
  attribute :execution_time, Float
  attribute :live_cells, Integer
  attribute :dead_cells, Integer
  attribute :timestamp, Integer # UNIX timestamp in nanosecondi

  # Validazioni
  validates :measurement, presence: true
  validates :simulation_id, presence: true
  validates :generation_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :execution_time, presence: true, numericality: true # Deve essere un numero
  validates :live_cells, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :dead_cells, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :timestamp, presence: true, numericality: { only_integer: true, greater_than: 0 } # Assicura che il timestamp sia positivo

  # La configurazione dell'InfluxDB
  self.influxdb_database = 'mydatabase'
  self.influxdb_client = InfluxDB::Client.new(
    host: 'localhost',
    port: 8086,
    username: 'myuser',
    password: 'mypassword'
  )

end
