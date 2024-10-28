# app/services/relazione_celle_service.rb
class RelazioneCelleService
  def initialize(repository = RelazioneCelleRepositoryImpl.new)
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
