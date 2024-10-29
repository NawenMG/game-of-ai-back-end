# app/controllers/relazio_celle_graphql_controller.rb
class RelazioCelleGraphqlController < ApplicationController
  # POST /graphql
  def execute
    query = params[:query]
    variables = ensure_hash(params[:variables])
    operation_name = params[:operationName]

    # Invia un messaggio a Kafka per la query eseguita
    success_message = "GraphQL query executed: #{query}, variables: #{variables}, operation_name: #{operation_name}"
    $kafka.deliver_message(success_message, topic: 'graphql_queries')

    # Usa la cache locale per 6 ore
    local_cache_key = "graphql/#{Digest::MD5.hexdigest(query)}_#{Digest::MD5.hexdigest(variables.to_s)}"
    local_cache_result = Rails.cache.fetch(local_cache_key, expires_in: 6.hours) do
      gameOfLifeSchema.execute(query, variables: variables, operation_name: operation_name)
    end

    # Usa la cache distribuita per 12 ore
    distributed_cache_key = "graphql/distributed/#{Digest::MD5.hexdigest(query)}_#{Digest::MD5.hexdigest(variables.to_s)}"
    distributed_cache_result = Rails.cache.fetch(distributed_cache_key, expires_in: 12.hours) do
      local_cache_result # Calcola solo se non è presente nella cache distribuita
    end

    render json: distributed_cache_result
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
