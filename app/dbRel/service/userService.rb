#Normale implementazione del service
class UserService
  def initialize(UserRepository)
    @user_repository = UserRepository
  end

  # Trova un utente per ID
  def find_user_by_id(id)
    @user_repository.find_by_id(id)
  end

  # Trova un utente per nome utente
  def find_user_by_username(username)
    @user_repository.find_by_username(username)
  end

  # Crea un nuovo utente
  def create_user(user_params)
    # Esegui qui eventuali validazioni sui dati prima di salvarli
    @user_repository.save(user_params)
  end

  # Aggiorna un utente esistente
  def update_user(user_params)
    @user_repository.save(user_params)
  end

  # Elimina un utente
  def delete_user(id)
    @user_repository.delete(id)
  end

  # Trova tutti gli utenti
  def find_all_users
    @user_repository.find_all
  end

  # Cerca utenti per nome
  def search_users_by_name(name)
    @user_repository.find_by_name(name)
  end

  # Ordina utenti per attributo specificato
  def order_users_by(attribute, direction = 'asc')
    @user_repository.order_by(attribute, direction)
  end
end
