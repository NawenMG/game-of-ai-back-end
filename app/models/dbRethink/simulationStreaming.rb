class SimulationStreaming
  include ActiveModel::Model # Include ActiveModel per le validazioni

  attr_accessor :id, :simulation_id, :user_id, :generation_number, :grid_state, :timestamp

  def initialize(attributes = {})
    @id = attributes[:id]
    @simulation_id = attributes[:simulation_id]
    @user_id = attributes[:user_id]
    @generation_number = attributes[:generation_number]
    @grid_state = attributes[:grid_state]
    @timestamp = attributes[:timestamp]
  end

  # Validazioni
  validates :simulation_id, presence: true
  validates :user_id, presence: true
  validates :generation_number, presence: true, numericality: { only_integer: true } # Deve essere un intero
  validates :grid_state, presence: true
  validates :timestamp, presence: true

  # Validazione personalizzata per controllare che il timestamp non sia nel futuro
  validate :timestamp_is_not_in_the_future

  private

  def timestamp_is_not_in_the_future
    if timestamp.present? && timestamp > Time.current
      errors.add(:timestamp, "non può essere una data futura.")
    end
  end
end
