# app/graphql/types/relazione_cella_type.rb
module Types
  class RelazioneCellaType < BaseObject
    field :from, String, null: false
    field :to, String, null: false
    field :relationship, String, null: false
  end
end
