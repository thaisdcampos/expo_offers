class VerifyOfferAvailabilityJob < ApplicationJob
  queue_as :default

  def perform(*args)
    disabled_offer = Offer.disabled.where('active_from <= ?', Time.current)
    enabled_offer = Offer.enabled.where('active_until >= ?', Time.current)
    offers = enabled_offer + disabled_offer

    offers.each do |offer|
      offer.set_offer_availability
    end

    VerifyOfferAvailabilityJob.set(wait: 2.minutes).perform_later
  rescue => error
    Rails.logger.error error.message
    VerifyOfferAvailabilityJob.set(wait: 2.minutes).perform_later
  end
end
