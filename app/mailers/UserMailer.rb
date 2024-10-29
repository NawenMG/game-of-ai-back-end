# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: 'your_email@example.com'

  def notify_user(user, data)
    @data = data
    mail(to: user.email, subject: 'Risultati della tua simulazione di Game of AO')
  end
end
