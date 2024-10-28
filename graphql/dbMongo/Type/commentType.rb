# app/graphql/types/comment_type.rb

module Types #Definizione della struttura dati
  class CommentType < BaseObject
    field :id, ID, null: false
    field :simulation_id, ID, null: false
    field :user_id, String, null: false
    field :comment, String, null: false
    field :explanation, String, null: false
    field :timestamp, GraphQL::Types::ISO8601DateTime, null: false
  end
end
