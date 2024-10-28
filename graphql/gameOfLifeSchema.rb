# app/graphql/my_app_schema.rb

class gameOfLifeSchema < GraphQL::Schema
  query(Types::QueryType)

  # Definisci il tuo tipo di query, possiamo avere query o mutation(modifica dati)
  class QueryType < BaseObject
    field :comments, resolver: Queries::CommentsQuery
  end
end
