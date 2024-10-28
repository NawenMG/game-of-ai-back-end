# app/repositories/cella_repository_interface.rb
module CellaRepositoryImpl
  def get_all
    raise NotImplementedError, "Questo metodo deve essere implementato"
  end

  def find_by_id(id)
    raise NotImplementedError, "Questo metodo deve essere implementato"
  end

  def create(attributes)
    raise NotImplementedError, "Questo metodo deve essere implementato"
  end

  def update(id, attributes)
    raise NotImplementedError, "Questo metodo deve essere implementato"
  end

  def delete(id)
    raise NotImplementedError, "Questo metodo deve essere implementato"
  end
end
