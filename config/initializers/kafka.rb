# config/initializers/kafka.rb
require 'kafka'

$kafka = Kafka.new(seed_brokers: ['localhost:9092'])
