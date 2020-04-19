class VerifyUnavailableOffersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    offers = Offer.where('created_at = ?', Time.current.yesterday)

    offers.each do |offer|
      offer.verify_status
    end
  end
end
