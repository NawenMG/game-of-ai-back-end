module Types
  class ArchiviazioneSimulazioniType < Types::BaseObject
    field :user_id, ID, null: false
    field :simulation_id, ID, null: false
    field :generation, Integer, null: false
    field :grid_state, String, null: false
    field :created_at, String, null: false
  end
end
