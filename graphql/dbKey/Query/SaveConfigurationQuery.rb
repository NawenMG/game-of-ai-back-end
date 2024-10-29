# app/graphql/queries/save_configurations_query.rb
module Queries
  class SaveConfigurationsQuery < BaseQuery
    type [Types::SaveConfigurationType], null: false

    def resolve
      repository = SaveConfigurationRepositoryImpl.new
      service = SaveConfigurationService.new(repository)
      service.get_all_configurations
    end
  end
end
