namespace :offer do
  desc 'Run a job to verify offer availability'
  task verify_offer_availability: :environment do
    Rails.logger.info "Entrou na rake"
    VerifyOfferAvailabilityJob.perform_later
    Rails.logger.info "Passou do perform_later"
  end
end
