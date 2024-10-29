# app/graphql/types/query_type.rb
module Types
  class QueryType < BaseObject
    field :simulation_results, [SimulationResultsType], null: false

    def simulation_results
      SimulationResults.all
    end

    field :simulation_result, SimulationResultType, null: false do
      argument :simulation_name, String, required: true
    end

    def simulation_result(simulation_name:)
      SimulationResults.find_by(simulation_name: simulation_name)
    end
  end
end
