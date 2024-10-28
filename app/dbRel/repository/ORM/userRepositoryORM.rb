=begin class UserRepositoryORM
  include UserRepository

  # Trova un utente per ID
  def find_by_id(id)
    user = User.find_by(user_id: id)
    user ? user : { error: "User not found" } #Restituisce il risultato o l'errore
  end

  # Trova un utente per nome utente
  def find_by_username(username)
    user = User.find_by(username: username)
    user ? user : { error: "User not found" }
  end

  # Salva un nuovo utente o aggiorna uno esistente
  def save(user)
    if user.save
      { message: 'User saved successfully' }
    else
      { error: 'Failed to save user', details: user.errors.full_messages }
    end
  end

  # Aggiorna i dati di un utente esistente
  def update(user)
    if user.save
      { message: 'User updated successfully' }
    else
      { error: 'Failed to update user', details: user.errors.full_messages }
    end
  end

  # Elimina un utente
  def delete(user)
    if user.persisted? && user.destroy
      { message: 'User deleted successfully' }
    else
      { error: 'Failed to delete user' }
    end
  end

  # Seleziona tutti gli utenti
  def find_all
    User.all
  end

  # Seleziona gli utenti in base al nome con LIKE
  def find_by_name(name)
    users = User.where("nome ILIKE ?", "%#{name}%")
    users.any? ? users : { error: "No users found with name: #{name}" }
  end

  # Ordina gli utenti per un attributo specificato
  def order_by(attribute, direction = 'asc')
    User.order("#{attribute} #{direction}")
  end
end
 =end