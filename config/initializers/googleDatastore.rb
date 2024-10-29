require "google/cloud/datastore"

Google::Cloud::Datastore.configure do |config|
  config.project_id = ENV['GOOGLE_CLOUD_PROJECT']
  config.credentials = ENV['GOOGLE_APPLICATION_CREDENTIALS']
end