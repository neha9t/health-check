# Load the Rails application.
require_relative 'application'

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!
