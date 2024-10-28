# app/repositories/relazione_celle_repository_impl.rb
require 'arangodb'

class RelazioneCelleRepositoryImpl
  include RelazioneCelleRepository

  def initialize
    @db = Arango::Database.new(name: 'your_database_name', host: 'localhost', port: 8529, username: 'root', password: 'your_password')
  end

  # Metodo GET: Recupera tutte le relazioni
  def get_all
    @db.collection('relazione_celle').all
  end

  # Metodo GET: Recupera una relazione per ID
  def find_by_id(id)
    @db.collection('relazione_celle').document(id)
  end

  # Metodo POST: Inserisce una nuova relazione
  def create(attributes)
    @db.collection('relazione_celle').insert(attributes)
  end

  # Metodo PUT: Aggiorna una relazione esistente
  def update(id, attributes)
    @db.collection('relazione_celle').replace(id, attributes)
  end

  # Metodo DELETE: Elimina una relazione per ID
  def delete(id)
    @db.collection('relazione_celle').delete(id)
  end
end
