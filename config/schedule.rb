job_type :rake, "cd :path && RAILS_ENV=:environment rake :task :output"

every 2.minutes do
  rake 'offer:verify_offer_availability', output: {error: 'log/cron-error.log', standard: 'log/cron.log'}
end

