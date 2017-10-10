class Check < ApplicationRecord

  after_commit :run_sidekiq, on: :create
  after_update :destroy_sidekiq_jobs, unless: :is_enabled?
  before_destroy :destroy_sidekiq_jobs
  before_save :default_values

  private

    def default_values
      self.enabled||= false
      if self.enabled == false
        self.is_site_online ||= "NA"
        self.last_run ||= "Awaiting: #{Time.now}"
      end
    end

    def run_sidekiq
     if self.enabled == true
        puts "Model method - triggered sidekiq"
        HealthCheckWorker.perform_async(self.id, self.url)
     end
    end
    
    def is_enabled?
      binding.pry
      return if self.enabled == false
    end
    
    def destroy_sidekiq_jobs
      binding.pry
        scheduled = Sidekiq::ScheduledSet.new
        scheduled.each do |job|
          if job.klass == 'HealthCheckWorker' && job.args.first == id
            job.delete
          end
    end
  end
end