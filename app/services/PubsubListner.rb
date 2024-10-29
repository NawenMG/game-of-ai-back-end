# app/services/pubsub_listener.rb
require "google/cloud/pubsub"
require "json"
require "rethinkdb"

class PubsubListener
  def initialize
    @pubsub = Google::Cloud::Pubsub.new
    @subscription = @pubsub.subscription("YOUR_SUBSCRIPTION_ID") # Sostituisci con il tuo subscription ID
    @r = RethinkDB::RQL.connect(host: 'localhost', port: 28015)
  end

  def listen
    @subscription.listen do |received_message|
      process_message(received_message)
      received_message.acknowledge!
    end
  end

  private

  def process_message(message)
    puts "Ricevuto messaggio: #{message.data}"
    data = JSON.parse(message.data)

    # Salva i dati in RethinkDB
    save_to_rethinkdb(data)

    # Log dell'esecuzione del tempo
    log_execution_time(data['execution_time'])

    # Invia notifiche agli utenti
    notify_users(data)
  end

  def save_to_rethinkdb(data)
    # Assicurati di avere la connessione a RethinkDB
    db = @r.db('test') # Sostituisci con il nome del tuo database
    db.table('execution_logs').insert(data).run
  end

  def log_execution_time(execution_time)
    Rails.logger.info "Esecuzione completata in #{execution_time} secondi"
    # Potresti anche voler loggare l'esecuzione nel database
  end

  def notify_users(data)
    user_ids = data['user_ids'] # Presumi che ci sia una lista di ID utenti nel messaggio
    user_ids.each do |user_id|
      user = User.find(user_id) # Assicurati che User sia un modello valido
      UserMailer.notify_user(user, data).deliver_later
      ActionCable.server.broadcast("simulation_streaming_channel", action: "notification", data: data)
    end
  end
end
