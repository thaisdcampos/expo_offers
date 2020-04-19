job_type :sidekiq, "cd :path && :environment_variable=:environment bundle exec sidekiq-client push :task :output"

set :output, "log/cron.log"

every 2.minutes do
  sidekiq 'VerifyUnavailableOffersJob'
end

