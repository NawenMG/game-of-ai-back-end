require "google/cloud/pubsub"

Google::Cloud::Pubsub.configure do |config|
  config.project_id = "YOUR_PROJECT_ID"
  config.credentials = "path/to/your/credentials.json" # Imposta il percorso delle credenziali
end
