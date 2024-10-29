# app/models/archiviazione_simulazioni.rb
class ArchiviazioneSimulazioni
  include Cassandra::Model
  include ActiveModel::Model # Include ActiveModel per le validazioni

  # Definire la tabella e le colonne
  table :archiviazione_simulazioni do
    key :user_id, Cassandra::Uuid
    key :simulation_id, Cassandra::Uuid
    column :generation, Integer
    column :grid_state, String
    column :created_at, Time
  end

  # Attributi accessibili
  attr_accessor :user_id, :simulation_id, :generation, :grid_state, :created_at

  # Validazioni
  validates :user_id, presence: true
  validates :simulation_id, presence: true
  validates :generation, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :grid_state, presence: true, length: { maximum: 255 }
  validates :created_at, presence: true

  def initialize(user_id:, simulation_id:, generation:, grid_state:, created_at: Time.now)
    @user_id = user_id
    @simulation_id = simulation_id
    @generation = generation
    @grid_state = grid_state
    @created_at = created_at
  end

end
