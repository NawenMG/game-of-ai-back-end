# db/seeds.rb

require 'faker'

10.times do
  User.create(
    nome: Faker::Name.first_name,
    cognome: Faker::Name.last_name,
    username: Faker::Internet.username,
    email: Faker::Internet.unique.email,
    password_hash: BCrypt::Password.create(Faker::Internet.password),
    role: ['admin', 'user'].sample,
    status: ['active', 'inactive'].sample,
    two_factor_enabled: [true, false].sample
  )
end
