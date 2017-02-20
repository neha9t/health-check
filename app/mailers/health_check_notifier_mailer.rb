class HealthCheckNotifierMailer < ApplicationMailer

  default from: 'nehatandon1@gmail.com'

  def send_health_condition_email
    mail( :to => 'nehatandon1@gmail.com',:subject => 'Your Website is running well!')
    # to:  email: 'nehatandon1@gmail.com'
    # subject = 'Ye mera email hai- Check Check!'
    # content = Content.new(type: 'text/plain', value: 'Health-Check Test: aapki website sahi chal rahi hai bhaisaheb')
    # mail = Mail.new(from, subject, to, content)

    #sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    #response = sg.client.mail._('send').post(request_body: mail.to_json)
    #puts response.status_code
    #puts response.body
    #puts response.headers
  end
end
