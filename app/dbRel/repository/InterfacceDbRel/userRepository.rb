# app/repositories/user_repository.rb
module UserRepository
  def find_by_id(id) #Trova un utente per id
    raise NotImplementedError, "find_by_id must be implemented"
  end

  def find_by_username(username) #Trova un utente per username
    raise NotImplementedError, "find_by_username must be implemented"
  end

  def save(user)#Post/insert
    raise NotImplementedError, "save must be implemented"
  end

  def update(user)#Put/update
    raise NotImplementedError, "update must be implemented"
  end

  def delete(user)#Delete
    raise NotImplementedError, "delete must be implemented"
  end

  def find_all#Seleziona tutti i risultati
    raise NotImplementedError, "find_all must be implemented"
  end

  def find_by_name(name)#Trova per nome
    raise NotImplementedError, "find_by_name must be implemented"
  end

  def order_by(attribute, direction)#OrderBy
    raise NotImplementedError, "order_by must be implemented"
  end
end
