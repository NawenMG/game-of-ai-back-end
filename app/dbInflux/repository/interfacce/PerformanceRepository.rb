# app/repositories/performance_monitoring_repository_interface.rb
module PerformanceMonitoringRepositoryInterface
 
  def get_all
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

 
  def find_by_id(id)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end


  def create(attributes)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

  
  def update(id, attributes)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end

 
  def delete(id)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end
end
