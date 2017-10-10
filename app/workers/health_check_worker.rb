class HealthCheckWorker

  include Sidekiq::Worker   
    sidekiq_options :queue => :check, :retry => false, :backtrace => true
  
    ATTEMPTS = {}

  def perform(details_id, details_url)
    begin
      ATTEMPTS[details_id] = 0
      session_response = RestClient.get(details_url, headers={})
      session_code = session_response.code
      record = Check.find(details_id)
      if session_code ==200
        # HealthCheckNotifierMailer.send_health_condition_email.deliver 
        HealthCheckWorker.perform_in(record.interval.second.from_now, details_id, details_url)
        record.last_run = "#{Time.now}"
        record.is_site_online = "YES"
        record.save
      elsif session_code !=200
        binding.pry
        record.is_site_online = "NO"
        ATTEMPTS[details_id]+=1
        (1..9).each do |count|
          HealthCheckWorker.perform_async(details_id)
          ATTEMPTS[details_id]+=1
          retry_when_session_code_fails(details_id)
        end
      end
    rescue 
      record = Check.find(details_id)
      record.is_site_online = "NO"
      record.last_run = "#{Time.now}"
      record.save
      
      ATTEMPTS[details_id]+=1
      puts ATTEMPTS
      puts "I am rescued"
    end
  end

  def retry_when_session_code_fails(details_id)
      if ATTEMPTS[details_id] == 3
        # HealthCheckNotifierMailer.send_health_condition_email.deliver  
      elsif ATTEMPTS[details_id] == 5
        # HealthCheckNotifierMailer.send_health_condition_email.deliver
        ATTEMPTS[details_id] == 0
      end
  end
end