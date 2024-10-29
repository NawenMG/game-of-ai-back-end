# app/graphql/types/simulation_result_type.rb
module Types
  class SimulationResultsType < BaseObject
    field :user_id, Integer, null: false
    field :result_id, Integer, null: false
    field :simulation_name, String, null: false
    field :count, Integer, null: false
    field :grid_size, String, null: false
    field :initial_state, String, null: false
    field :final_state, String, null: false
    field :completed, Boolean, null: false
    field :status, String, null: false
    field :creation_date, GraphQL::Types::ISO8601DateTime, null: false
    field :media_url, String, null: false
    field :input_parameters, GraphQL::Types::JSON, null: false
    field :ai_predictions, GraphQL::Types::JSON, null: false
  end
end
