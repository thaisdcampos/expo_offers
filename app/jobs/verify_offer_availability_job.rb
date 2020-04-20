class VerifyOfferAvailabilityJob < ApplicationJob
  queue_as :default

  def perform(*args)
    #offers = Offer.where('created_at = ?', Time.current.yesterday)
    offers = Offer.all

    offers.each do |offer|
      offer.set_offer_availability
    end
  end
end
