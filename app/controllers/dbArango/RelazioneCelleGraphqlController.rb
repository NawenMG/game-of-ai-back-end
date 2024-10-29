# app/controllers/graphql_controller.rb
class RelazioCelleGraphqlController < ApplicationController
  # POST /graphql
  def execute
    query = params[:query]
    variables = ensure_hash(params[:variables])
    operation_name = params[:operationName]
    
    result = gameOfLifeSchema.execute(query, variables: variables, operation_name: operation_name)
    render json: result
  end

  private

  # Trasforma i parametri in un hash
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ensure_hash(JSON.parse(ambiguous_param))
    when Hash
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
