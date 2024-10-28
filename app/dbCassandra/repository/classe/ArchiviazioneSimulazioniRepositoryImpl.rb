class ArchiviazioneSimulazioniRepository
  include ArchiviazioneSimulazioniRepository
  
  def get_all
    # Seleziona tutto e ordina per created_at
    ArchiviazioneSimulazioni.order(created_at: :desc).all
  end

  def find_by_user_id(user_id)
    ArchiviazioneSimulazioni.where(user_id: user_id).all
  end

  def search_by_grid_state(grid_state)
    # Utilizzo di LIKE per cercare nel grid_state
    ArchiviazioneSimulazioni.where("grid_state LIKE ?", "%#{grid_state}%").all
  end

  def create(attributes)
    ArchiviazioneSimulazioni.create(attributes)
  end

  def update(user_id, simulation_id, attributes)
    record = ArchiviazioneSimulazioni.where(user_id: user_id, simulation_id: simulation_id).first
    return unless record
    record.update(attributes)
  end

  def delete(user_id, simulation_id)
    record = ArchiviazioneSimulazioni.where(user_id: user_id, simulation_id: simulation_id).first
    record&.destroy
  end
end


