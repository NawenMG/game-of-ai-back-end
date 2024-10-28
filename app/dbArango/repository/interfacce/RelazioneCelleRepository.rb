# app/repositories/relazione_celle_repository.rb
module RelazioneCelleRepository
  def get_all
    raise NotImplementedError
  end

  def find_by_id(id)
    raise NotImplementedError
  end

  def create(attributes)
    raise NotImplementedError
  end

  def update(id, attributes)
    raise NotImplementedError
  end

  def delete(id)
    raise NotImplementedError
  end
end
