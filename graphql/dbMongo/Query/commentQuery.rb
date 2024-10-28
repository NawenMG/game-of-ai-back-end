# app/graphql/queries/comments_query.rb

module Queries
  class CommentsQuery < BaseQuery
    type [Types::CommentType], null: false

    def resolve
      CommentRepositoryMongo.new.find_all
    end
  end
end
