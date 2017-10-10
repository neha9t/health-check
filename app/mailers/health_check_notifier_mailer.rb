class HealthCheckNotifierMailer < ApplicationMailer

  default from: 'nehatandon1@gmail.com'

  def send_health_condition_email

    mail( :to => 'nehatandon1@gmail.com',:subject => 'Your Website isnt running!')
  end
end
