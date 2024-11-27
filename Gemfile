source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.1", ">= 7.2.1.2"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
#Sorted_set
gem 'sorted_set', '~> 1.0', '>= 1.0.3'
##############################################################################################################################
#Postgresql
gem 'pg' 
#MongoDB
gem 'mongoid', '~> 9.0'
#Supporto BSON
gem 'bson', '~> 5.0'
#InfluxDB
gem 'influxdb-client', '~> 3.2'
#RethinkDB ASSICURATI CHE IL CONTAINER SIA IN ESECUZIONE
gem 'rethinkdb', '~> 2.3.0'
#Cassandra ASSICURATI CHE IL CONTAINER SIA IN ESECUZIONE
gem 'cassandra-driver', '~> 3.2', '>= 3.2.5'
#Arango db
gem 'arangorb', '~> 2.0', '>= 2.0.1'
#Faker
gem 'faker', '~> 3.5', '>= 3.5.1'
#bcrypt(user password)
gem 'bcrypt', '~> 3.1', '>= 3.1.20'
#SOAP API
gem 'savon', '~> 2.15', '>= 2.15.1'
#Graphql
gem 'graphql', '~> 2.3', '>= 2.3.19'
gem 'graphql-batch', '~> 0.6.0'
#Google Cloud datastore for key_value
gem 'google-cloud-datastore', '~> 2.10'
#SECURITY
gem 'devise', '~> 4.9', '>= 4.9.4' 
gem 'devise-jwt', '~> 0.12.1'
gem 'rotp', '~> 6.3' #Per l'autenticazione a due fattori
#GRPC
gem 'grpc', '~> 1.67'
gem 'grpc-tools', '~> 1.67'
#Google cloud storage
gem 'google-cloud-storage', '~> 1.52'
#Kafka
gem 'ruby-kafka', '~> 1.5'
#Google cloud pub sub
gem 'google-cloud-pubsub', '~> 2.19'
#Redis
gem 'redis', '~> 5.3'
#Mail
gem 'actionmailer', '~> 7.2', '>= 7.2.1.2'
###############################################################################################################################
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
