# config/initializers/influxdb.rb
InfluxDB::Client.new 'my_database', host: 'localhost', port: 8086
