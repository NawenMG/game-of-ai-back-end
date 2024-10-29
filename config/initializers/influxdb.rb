require 'influxdb-client'

InfluxDBClient = InfluxDB2::Client.new(
  'http://localhost:8086',
  'tuo_token',
  bucket: 'nome_bucket',
  org: 'nome_organizzazione'
)
