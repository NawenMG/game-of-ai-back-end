# app/repositories/simulation_streaming_repository.rb
require 'rethinkdb'
include RethinkDB::Shortcuts

require_relative 'simulation_streaming_repository_interface'

class SimulationStreamingRepository
  include SimulationStreamingRepositoryImpl

  def initialize
    @r = RethinkDB::RQL.new
    @connection = @r.connect(host: 'localhost', port: 28015) # Configurazione della connessione
  end

  def get_all
    @r.table('simulation_streaming').run(@connection).to_a
  end

  def find_by_id(id)
    @r.table('simulation_streaming').get(id).run(@connection)
  end

  def create(simulation)
    @r.table('simulation_streaming').insert(simulation).run(@connection)
  end

  def update(id, attributes)
    @r.table('simulation_streaming').get(id).update(attributes).run(@connection)
  end

  def delete(id)
    @r.table('simulation_streaming').get(id).delete.run(@connection)
  end
end
