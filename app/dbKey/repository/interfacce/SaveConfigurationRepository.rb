# app/repositories/save_configuration_repository.rb
module SaveConfigurationRepository
  def find_all
    raise NotImplementedError
  end

  def find_by_id(id)
    raise NotImplementedError
  end

  def create(save_configuration)
    raise NotImplementedError
  end

  def update(id, attributes)
    raise NotImplementedError
  end

  def delete(id)
    raise NotImplementedError
  end
end
