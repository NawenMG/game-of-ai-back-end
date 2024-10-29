=begin require 'arangorb'

ArangoDb.configure do |config|
  config.database = 'myapp_development'
  config.username = 'root'
  config.password = ENV['ARANGO_PASSWORD']
  config.host = 'localhost'
  config.port = 8529
end =end
 RICORDATI DI ATTIVARE IL CONTAINER RETHINKDB
