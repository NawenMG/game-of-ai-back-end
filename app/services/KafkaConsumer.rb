# app/services/kafka_consumers/kafka_consumer.rb

require 'kafka'
require 'google/cloud/storage'

class KafkaConsumer
  def initialize
    @kafka = Kafka.new(seed_brokers: ["localhost:9092"]) # Cambia con il tuo broker Kafka
    @consumer = @kafka.consumer(group_id: "my_group") # Scegli un ID gruppo unico per i tuoi consumatori
    @storage = Google::Cloud::Storage.new(
      project_id: 'YOUR_PROJECT_ID', # Sostituisci con il tuo project ID
      credentials: 'PATH_TO_YOUR_SERVICE_ACCOUNT_JSON' # Sostituisci con il percorso della chiave JSON
    )
    @bucket = @storage.bucket('YOUR_BUCKET_NAME') # Sostituisci con il tuo bucket GCS
  end

  def subscribe_to_topics
    # Elenco di tutti gli argomenti a cui ci si vuole iscrivere
    topics = [
      "two_factor_auth_success",
      "two_factor_auth_failure",
      "user_registration_success",
      "user_registration_failure",
      "user_login_success",
      "user_login_failure",
      "simulation_archived",
      "simulation_updated",
      "simulation_deleted",
      "simulation_result_created",
      "simulation_result_updated",
      "simulation_result_deleted",
      "configuration_created",
      "configuration_updated",
      "configuration_deleted",
      "performance_monitoring_created",
      "performance_monitoring_updated",
      "performance_monitoring_deleted",
      "simulation_streaming",
      "simulation_created",
      "simulation_updated",
      "simulation_deleted",
      "comment_created",
      "comment_updated",
      "comment_deleted",
      "graphql_success",
      "graphql_error"
    ]

    topics.each { |topic| @consumer.subscribe(topic) }
  end

  def run
    subscribe_to_topics

    @consumer.each_message do |message|
      handle_message(message)
    end
  end

  private

  def handle_message(message)
    case message.topic
    when "two_factor_auth_success"
      handle_two_factor_auth_success(message)
    when "two_factor_auth_failure"
      handle_two_factor_auth_failure(message)
    when "user_registration_success"
      handle_user_registration_success(message)
    when "user_registration_failure"
      handle_user_registration_failure(message)
    when "user_login_success"
      handle_user_login_success(message)
    when "user_login_failure"
      handle_user_login_failure(message)
    when "simulation_archived"
      handle_simulation_archived(message)
    when "simulation_updated"
      handle_simulation_updated(message)
    when "simulation_deleted"
      handle_simulation_deleted(message)
    when "simulation_result_created"
      handle_simulation_result_created(message)
    when "simulation_result_updated"
      handle_simulation_result_updated(message)
    when "simulation_result_deleted"
      handle_simulation_result_deleted(message)
    when "configuration_created"
      handle_configuration_created(message)
    when "configuration_updated"
      handle_configuration_updated(message)
    when "configuration_deleted"
      handle_configuration_deleted(message)
    when "performance_monitoring_created"
      handle_performance_monitoring_created(message)
    when "performance_monitoring_updated"
      handle_performance_monitoring_updated(message)
    when "performance_monitoring_deleted"
      handle_performance_monitoring_deleted(message)
    when "simulation_streaming"
      handle_simulation_streaming(message)
    when "simulation_created"
      handle_simulation_created(message)
    when "simulation_updated"
      handle_simulation_updated(message)
    when "simulation_deleted"
      handle_simulation_deleted(message)
    when "comment_created"
      handle_comment_created(message)
    when "comment_updated"
      handle_comment_updated(message)
    when "comment_deleted"
      handle_comment_deleted(message)
    when "graphql_success"
      handle_graphql_success(message)
    when "graphql_error"
      handle_graphql_error(message)
    else
      Rails.logger.error("Unknown topic: #{message.topic}")
    end
  end

  # Esempi di metodi di gestione per i messaggi
  def handle_two_factor_auth_success(message)
    Rails.logger.info("Two-factor authentication succeeded: #{message.value}")
    save_to_gcs("two_factor_auth_success/#{Time.now.to_i}.txt", message.value)
  end

  def handle_two_factor_auth_failure(message)
    Rails.logger.error("Two-factor authentication failed: #{message.value}")
    save_to_gcs("two_factor_auth_failure/#{Time.now.to_i}.txt", message.value)
  end

  def handle_user_registration_success(message)
    Rails.logger.info("User registered successfully: #{message.value}")
    save_to_gcs("user_registration_success/#{Time.now.to_i}.txt", message.value)
  end

  def handle_user_registration_failure(message)
    Rails.logger.error("User registration failed: #{message.value}")
    save_to_gcs("user_registration_failure/#{Time.now.to_i}.txt", message.value)
  end

  def handle_user_login_success(message)
    Rails.logger.info("User login successful: #{message.value}")
    save_to_gcs("user_login_success/#{Time.now.to_i}.txt", message.value)
  end

  def handle_user_login_failure(message)
    Rails.logger.error("User login failed: #{message.value}")
    save_to_gcs("user_login_failure/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_archived(message)
    Rails.logger.info("Simulation archived: #{message.value}")
    save_to_gcs("simulation_archived/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_updated(message)
    Rails.logger.info("Simulation updated: #{message.value}")
    save_to_gcs("simulation_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_deleted(message)
    Rails.logger.info("Simulation deleted: #{message.value}")
    save_to_gcs("simulation_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_result_created(message)
    Rails.logger.info("Simulation result created: #{message.value}")
    save_to_gcs("simulation_result_created/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_result_updated(message)
    Rails.logger.info("Simulation result updated: #{message.value}")
    save_to_gcs("simulation_result_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_result_deleted(message)
    Rails.logger.info("Simulation result deleted: #{message.value}")
    save_to_gcs("simulation_result_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_configuration_created(message)
    Rails.logger.info("Configuration created: #{message.value}")
    save_to_gcs("configuration_created/#{Time.now.to_i}.txt", message.value)
  end

  def handle_configuration_updated(message)
    Rails.logger.info("Configuration updated: #{message.value}")
    save_to_gcs("configuration_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_configuration_deleted(message)
    Rails.logger.info("Configuration deleted: #{message.value}")
    save_to_gcs("configuration_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_performance_monitoring_created(message)
    Rails.logger.info("Performance monitoring created: #{message.value}")
    save_to_gcs("performance_monitoring_created/#{Time.now.to_i}.txt", message.value)
  end

  def handle_performance_monitoring_updated(message)
    Rails.logger.info("Performance monitoring updated: #{message.value}")
    save_to_gcs("performance_monitoring_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_performance_monitoring_deleted(message)
    Rails.logger.info("Performance monitoring deleted: #{message.value}")
    save_to_gcs("performance_monitoring_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_streaming(message)
    Rails.logger.info("Streaming simulations: #{message.value}")
    save_to_gcs("simulation_streaming/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_created(message)
    Rails.logger.info("Simulation created: #{message.value}")
    save_to_gcs("simulation_created/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_updated(message)
    Rails.logger.info("Simulation updated: #{message.value}")
    save_to_gcs("simulation_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_simulation_deleted(message)
    Rails.logger.info("Simulation deleted: #{message.value}")
    save_to_gcs("simulation_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_comment_created(message)
    Rails.logger.info("Comment created: #{message.value}")
    save_to_gcs("comment_created/#{Time.now.to_i}.txt", message.value)
  end

  def handle_comment_updated(message)
    Rails.logger.info("Comment updated: #{message.value}")
    save_to_gcs("comment_updated/#{Time.now.to_i}.txt", message.value)
  end

  def handle_comment_deleted(message)
    Rails.logger.info("Comment deleted: #{message.value}")
    save_to_gcs("comment_deleted/#{Time.now.to_i}.txt", message.value)
  end

  def handle_graphql_success(message)
    Rails.logger.info("GraphQL query executed successfully: #{message.value}")
    save_to_gcs("graphql_success/#{Time.now.to_i}.txt", message.value)
  end

  def handle_graphql_error(message)
    Rails.logger.error("GraphQL query execution error: #{message.value}")
    save_to_gcs("graphql_error/#{Time.now.to_i}.txt", message.value)
  end

  # Metodo per salvare i messaggi in Google Cloud Storage
  def save_to_gcs(filename, content)
    file = @bucket.create_file StringIO.new(content), filename
    Rails.logger.info("File #{filename} salvato in Google Cloud Storage.")
  rescue StandardError => e
    Rails.logger.error("Errore durante il salvataggio su GCS: #{e.message}")
  end
end
