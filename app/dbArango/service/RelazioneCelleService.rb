# app/services/relazione_cella_service.rb
class RelazioneCellaService
  def initialize
    @repository = RelazioneCelleRepositoryImpl.new
  end

  # Recupera tutte le relazioni
  def get_all_relationships
    @repository.get_all
  end

  # Recupera una relazione per ID
  def get_relationship_by_id(id)
    @repository.find_by_id(id)
  end

  # Crea una nuova relazione
  def create_relationship(attributes)
    @repository.create(attributes)
  end

  # Aggiorna una relazione esistente
  def update_relationship(id, attributes)
    @repository.update(id, attributes)
  end

  # Elimina una relazione per ID
  def delete_relationship(id)
    @repository.delete(id)
  end
end
