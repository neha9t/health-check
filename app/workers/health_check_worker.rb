require_relative '../mailers/sendgrid'
require 'pry'

class HealthCheckWorker

  include Sidekiq::Worker   
    sidekiq_options :queue => :check, :retry => true, :backtrace => true
  
  def perform(details_id)
    puts "I am inside Sidekiq perform method"
    record = Check.find(:id => details_id)
    puts record
    record_url = record.first.url
    if record.first.enabled == true
      count = 0
      session_response = RestClient.get(record_url, headers={})
      session_code = session_response.code

      if session_code != 200
          # Send mail
      else
          mail_health_check("nehatandon1@gmail.com")
          count = count + 1
          count.to_s
          puts "I am inside ELSE before recurring for #{count} times"
          #Resque.enqueue_in(record.first.interval.second.from_now, Check, details_id)
          HealthCheckWorker.perform_in(record.first.interval.second.from_now,details_id)

          record.first.last_run = "Last Run: #{Time.now}"
          record.save
          puts "I am inside ELSE after recurring for #{count} times"
      end
    end
  end
end