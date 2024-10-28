class UserRepositorySQL
  include UserRepository

  ALLOWED_ORDER_COLUMNS = %w[nome cognome username email role status].freeze #%w permette di omettere le virgole nell'array, freeze lo rende immutabile
  #ALLOWED_ORDER_COLUMNS: È una costante che rappresenta un elenco di colonne che possono essere utilizzate per ordinare i risultati quando si eseguono query sul database.
  #Quando viene utilizzato nel metodo order_by, serve per verificare se la colonna specificata per l'ordinamento è presente nell'elenco consentito. Questo aiuta a prevenire attacchi di SQL injection, in quanto si assicura che solo le colonne previste possano essere utilizzate nelle query SQL.

  def initialize(connection)
    @connection = connection
  end

  # Trova un utente per ID
  def find_by_id(id)
    raise ArgumentError, "Invalid ID" unless valid_id?(id)  # Validazione per sqlinjection
    result = @connection.exec_params("SELECT * FROM users WHERE user_id = $1", [id]) #execparams offre robustezza contro le sql injection
    user = result.first
    user ? user : { error: "User not found" } #Ritorna un risultato o un errore
  end

  # Trova un utente per nome utente
  def find_by_username(username)
    raise ArgumentError, "Invalid Username" if username.empty?  # Validazione
    result = @connection.exec_params("SELECT * FROM users WHERE username = $1", [username])
    user = result.first
    user ? user : { error: "User not found" }
  end

  # Salva un nuovo utente o aggiorna uno esistente
  def save(user)
    validate_user(user)  # Validazione dell'utente
    if user[:user_id]
      # Aggiorna l'utente esistente
      result = @connection.exec_params(
        "UPDATE users SET nome = $1, cognome = $2, username = $3, email = $4, password_hash = $5, role = $6, status = $7, session_token = $8, jwt_token = $9, two_factor_enabled = $10, profile_picture = $11 WHERE user_id = $12",
        [user[:nome], user[:cognome], user[:username], user[:email], user[:password_hash], user[:role], user[:status], user[:session_token], user[:jwt_token], user[:two_factor_enabled], user[:profile_picture], user[:user_id]]
      )
      { message: 'User updated successfully' }
    else
      # Salva un nuovo utente
      @connection.exec_params(
        "INSERT INTO users (nome, cognome, username, email, password_hash, role, status, session_token, jwt_token, two_factor_enabled, profile_picture) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)",
        [user[:nome], user[:cognome], user[:username], user[:email], user[:password_hash], user[:role], user[:status], user[:session_token], user[:jwt_token], user[:two_factor_enabled], user[:profile_picture]]
      )
      { message: 'User saved successfully' }
    end
  end

  # Elimina un utente
  def delete(id)
    raise ArgumentError, "Invalid ID" unless valid_id?(id)  # Validazione
    result = @connection.exec_params("DELETE FROM users WHERE user_id = $1", [id])
    if result.cmd_tuples > 0
      { message: 'User deleted successfully' }
    else
      { error: 'Failed to delete user or user not found' }
    end
  end

  # Seleziona tutti gli utenti
  def find_all
    result = @connection.exec_params("SELECT * FROM users", [])
    result.map { |row| row }
  end

  # Seleziona gli utenti in base al nome con LIKE
  def find_by_name(name)
    raise ArgumentError, "Invalid Name" if name.empty?  # Validazione
    result = @connection.exec_params("SELECT * FROM users WHERE nome ILIKE $1", ["%#{name}%"])
    users = result.to_a
    users.any? ? users : { error: "No users found with name: #{name}" }
  end

  # Ordina gli utenti per un attributo specificato
  def order_by(attribute, direction = 'asc')
    raise ArgumentError, "Invalid attribute" unless ALLOWED_ORDER_COLUMNS.include?(attribute)  # Validazione
    raise ArgumentError, "Invalid direction" unless %w[asc desc].include?(direction)  # Validazione
    result = @connection.exec_params("SELECT * FROM users ORDER BY #{attribute} #{direction}", [])
    result.map { |row| row }
  end

  private

  def valid_id?(id)
    id.is_a?(Integer) && id.positive?  # Validazione semplice per l'ID
  end

  def validate_user(user)
    raise ArgumentError, "Invalid user data" if user.nil? || user[:username].nil? || user[:email].nil?
    # Aggiungi ulteriori validazioni come necessario
  end
end
