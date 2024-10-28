# app/repositories/simulation_streaming_repository_interface.rb

module SimulationStreamingRepositoryInterface
  # Definizione del metodo GET per ottenere tutti i record
  def get_all
    raise NotImplementedError, 'get_all must be implemented in the repository'
  end

  # Definizione del metodo GET per trovare un record per ID
  def find_by_id(id)
    raise NotImplementedError, 'find_by_id must be implemented in the repository'
  end

  # Definizione del metodo POST per creare un nuovo record
  def create(simulation)
    raise NotImplementedError, 'create must be implemented in the repository'
  end

  # Definizione del metodo UPDATE per aggiornare un record esistente
  def update(id, attributes)
    raise NotImplementedError, 'update must be implemented in the repository'
  end

  # Definizione del metodo DELETE per eliminare un record per ID
  def delete(id)
    raise NotImplementedError, 'delete must be implemented in the repository'
  end
end
