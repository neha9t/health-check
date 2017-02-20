class Check < ApplicationRecord
  puts "I am inside Model"
  after_commit :run_sidekiq, on: :create

  private
    def run_sidekiq
 #     if self.enabled == "true"
        puts "I am inside after_commit trigger run_sidekiq"
        HealthCheckWorker.perform_async(self.id)
  #    end
    end
end