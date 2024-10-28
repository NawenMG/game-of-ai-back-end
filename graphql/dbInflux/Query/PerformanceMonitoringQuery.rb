# app/graphql/queries/performance_monitorings_query.rb
module Queries
  class PerformanceMonitoringsQuery < BaseQuery
    type [Types::PerformanceMonitoringType], null: false

    def resolve
      PerformanceMonitoringService.new.get_all
    end
  end
end
