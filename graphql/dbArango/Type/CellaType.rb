# app/graphql/types/cella_type.rb
module Types
  class CellaType < BaseObject
    field :key, String, null: false
    field :x, Integer, null: false
    field :y, Integer, null: false
    field :is_alive, Boolean, null: false
    field :generation, Integer, null: false
  end
end
