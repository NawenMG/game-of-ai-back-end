# app/repositories/cella_repository.rb
class CellaRepositoryImpl
  include RelazioneCelleRepositoryImpl

  def initialize
    @db = ArangoDB::Database.new('mydatabase') # Modifica secondo le tue configurazioni
  end

  # Recupera tutte le celle
  def get_all
    @db.collection('celle').all
  end

  # Recupera una cella per ID
  def find_by_id(id)
    @db.collection('celle').get(id)
  end

  # Inserisce una nuova cella
  def create(attributes)
    @db.collection('celle').insert(attributes)
  end

  # Aggiorna una cella esistente
  def update(id, attributes)
    @db.collection('celle').update(id, attributes)
  end

  # Elimina una cella per ID
  def delete(id)
    @db.collection('celle').delete(id)
  end
end
