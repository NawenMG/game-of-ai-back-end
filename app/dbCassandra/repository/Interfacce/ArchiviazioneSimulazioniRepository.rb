module ArchiviazioneSimulazioniRepository
  # Recupera tutti i record ordinati per created_at
  def get_all
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end

  # Recupera i record per user_id
  def find_by_user_id(user_id)
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end

  # Cerca i record basati sul grid_state utilizzando LIKE
  def search_by_grid_state(grid_state)
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end

  # Inserisce un nuovo record
  def create(attributes)
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end

  # Aggiorna un record esistente
  def update(user_id, simulation_id, attributes)
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end

  # Elimina un record per user_id e simulation_id
  def delete(user_id, simulation_id)
    raise NotImplementedError, 'This method must be implemented in the class including this module.'
  end
end
