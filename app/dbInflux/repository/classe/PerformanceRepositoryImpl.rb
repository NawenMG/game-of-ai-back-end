# app/repositories/performance_monitoring_repository.rb
class PerformanceMonitoringRepositoryImpl
  include PerformanceMonitoringRepository

  def initialize
    @client = InfluxDB::Client.new
  end

  # Recupera tutti i record
  def get_all
    @client.query('SELECT * FROM performance_monitoring')
  end

  # Recupera un record per ID
  def find_by_id(id)
    @client.query("SELECT * FROM performance_monitoring WHERE simulation_id = '#{id}'")
  end

  # Inserisce un nuovo record
  def create(attributes)
    @client.write_point('performance_monitoring', attributes)
  end

  # Aggiorna un record esistente
  def update(id, attributes)
    # InfluxDB non supporta l'aggiornamento di punti esistenti, di solito si usa la scrittura di un nuovo punto con lo stesso timestamp
    create(attributes.merge(simulation_id: id))
  end

  # Elimina un record per ID
  def delete(id)
    @client.query("DELETE FROM performance_monitoring WHERE simulation_id = '#{id}'")
  end
end
