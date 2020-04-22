# frozen_string_literal: true

class VerifyOfferAvailabilityJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    disabled_offer = Offer.disabled.where('active_from <= ?', Time.current)
    enabled_offer = Offer.enabled.where('active_until >= ?', Time.current)
    offers = enabled_offer + disabled_offer

    offers.each(&:set_offer_availability)

    VerifyOfferAvailabilityJob.set(wait: 2.minutes).perform_later
  rescue StandardError => e
    Rails.logger.error e.message
    VerifyOfferAvailabilityJob.set(wait: 2.minutes).perform_later
  end
end
