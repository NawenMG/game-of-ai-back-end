# app/services/cella_service.rb
class CellaService
  def initialize
    @repository = CellaRepositoryImpl.new
  end

  # Recupera tutte le celle
  def get_all_cells
    @repository.get_all
  end

  # Recupera una cella per ID
  def get_cell_by_id(id)
    @repository.find_by_id(id)
  end

  # Crea una nuova cella
  def create_cell(attributes)
    @repository.create(attributes)
  end

  # Aggiorna una cella esistente
  def update_cell(id, attributes)
    @repository.update(id, attributes)
  end

  # Elimina una cella per ID
  def delete_cell(id)
    @repository.delete(id)
  end
end
