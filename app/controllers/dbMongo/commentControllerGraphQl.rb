# app/controllers/graphql_controller.rb
class GraphqlController < ApplicationController
  def execute
    result = gameOfLifeSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: {},
      operation_name: params[:operationName]
    )
    render json: result
  end

  private

  # Per assicurarti che i parametri delle variabili siano un hash
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      return {} if ambiguous_param.blank?
      JSON.parse(ambiguous_param) rescue {}
    when Hash
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
