namespace :offer do
  desc 'Run a job to verify offer availability'
  task verify_offer_availability: :environment do
    VerifyOfferAvailabilityJob.perform_later
  end
end
