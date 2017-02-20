class HealthCheckWorker

  include Sidekiq::Worker
    sidekiq_options :queue => :check, :retry => false, :backtrace => true

  def perform(details_id)
    puts "I am inside Sidekiq perform method"
    record = Check.find(details_id)
    puts record
    record_url = record.url
    if record.enabled == true
      count = 0
      session_response = RestClient.get(record_url, headers={})
      session_code = session_response.code

      if session_code != 200
          # Send mail
      else
          HealthCheckNotifierMailer.send_health_condition_email.deliver
          # HealthCheckWorker.perform_in(record.interval.second.from_now,details_id)
          record.last_run = "Last Run: #{Time.now}"
          record.save
      end
    end
  end
end