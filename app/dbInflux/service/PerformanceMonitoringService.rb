# app/services/performance_monitoring_service.rb
class PerformanceMonitoringService
  def initialize(repository = PerformanceMonitoringRepository.new)
    @repository = repository
  end

  def get_all
    @repository.get_all
  end

  def find_by_id(id)
    @repository.find_by_id(id)
  end

  def create(attributes)
    @repository.create(attributes)
  end

  def update(id, attributes)
    @repository.update(id, attributes)
  end

  def delete(id)
    @repository.delete(id)
  end
end
