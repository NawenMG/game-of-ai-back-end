class ArchiviazioneSimulazioni
  include Cassandra::Model

  # Definire la tabella e le colonne
  table :archiviazione_simulazioni do
    key :user_id, Cassandra::Uuid
    key :simulation_id, Cassandra::Uuid
    column :generation, Integer
    column :grid_state, String
    column :created_at, Time
  end
end
