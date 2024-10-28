# app/graphql/types/query_type.rb
module Types
  class QueryType < Types::BaseObject
    field :relazione_celle, [Types::RelazioneCelleType], null: false

    def relazione_celle
      CellaService.new.get_all
    end
  end
end
