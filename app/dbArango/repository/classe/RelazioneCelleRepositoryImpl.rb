# app/repositories/relazione_cella_repository.rb
class RelazioneCellaRepositoryImpl
  include RelazioneCelleRepositoryImpl # Riutilizziamo l'interfaccia

  def initialize
    @db = ArangoDB::Database.new('mydatabase') # Modifica secondo le tue configurazioni
  end

  # Recupera tutte le relazioni
  def get_all
    @db.collection('relazione_cella').all
  end

  # Recupera una relazione per ID
  def find_by_id(id)
    @db.collection('relazione_cella').get(id)
  end

  # Inserisce una nuova relazione
  def create(attributes)
    @db.collection('relazione_cella').insert(attributes)
  end

  # Aggiorna una relazione esistente
  def update(id, attributes)
    @db.collection('relazione_cella').update(id, attributes)
  end

  # Elimina una relazione per ID
  def delete(id)
    @db.collection('relazione_cella').delete(id)
  end
end
