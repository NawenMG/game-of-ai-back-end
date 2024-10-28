# app/graphql/types/relazione_celle_type.rb
module Types
  class RelazioneCelleType < Types::BaseObject
    field :id, ID, null: false
    field :cell_id, String, null: false
    field :simulation_id, String, null: false
    field :relationship_type, String, null: false
    field :timestamp, String, null: false
  end
end
