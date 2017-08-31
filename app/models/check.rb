class Check < ApplicationRecord

  after_commit :run_sidekiq, on: :create
  before_destroy :destroy_sidekiq_jobs

  private
    def run_sidekiq
 #     if self.enabled == "true"
        puts "I am inside after_commit trigger run_sidekiq"
        HealthCheckWorker.perform_async(self.id)
  #    end
    end
    def destroy_sidekiq_jobs
      scheduled = Sidekiq::ScheduledSet.new
      scheduled.each do |job|
        if job.klass == 'HealthCheckWorker' && job.args.first == id
          job.delete
        end
    end
  end
end