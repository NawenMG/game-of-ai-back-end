# config/initializers/rethinkdb.rb
require 'rethinkdb'

# Creiamo un'istanza di RethinkDB
r = RethinkDB::RQL.new

begin
  # Connettiamoci a RethinkDB
  connection = r.connect(host: 'localhost', port: 28015)

  # Verifica se il database esiste, e crealo solo se non esiste
  unless r.db_list.run(connection).include?('myapp_development')
    r.db_create('myapp_development').run(connection)
    puts "Database 'myapp_development' creato con successo."
  else
    puts "Il database 'myapp_development' esiste già."
  end
rescue StandardError => e
  puts "Si è verificato un errore durante la connessione a RethinkDB: #{e.message}"
end
