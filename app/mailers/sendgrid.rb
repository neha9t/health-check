# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

def mail_health_check(to_email_id)
	from = Email.new(email: 'nehatandon1@gmail.com')
	to = Email.new(email: to_email_id)
	subject = 'Ye mera email hai- Check Check!'
	content = Content.new(type: 'text/plain', value: 'Health-Check Test: aapki website sahi chal rahi hai bhaisaheb')
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	puts response.status_code
	puts response.body
	puts response.headers
end