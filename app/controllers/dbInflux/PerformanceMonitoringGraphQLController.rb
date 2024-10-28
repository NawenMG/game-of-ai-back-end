# app/controllers/graphql_controller.rb
class GraphqlController < ApplicationController
  def execute
    result = gameOfLifeSchema.execute(params[:query], variables: ensure_hash(params[:variables]))
    render json: result
  end

  private

  # Utilizza il metodo per garantire che i parametri siano una hash
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      JSON.parse(ambiguous_param) rescue {}
    when Hash
      ambiguous_param
    else
      {}
    end
  end
end
