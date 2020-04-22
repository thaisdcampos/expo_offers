# frozen_string_literal: true

class VerifyOfferAvailability < ActiveRecord::Migration[6.0]
  def change
    VerifyOfferAvailabilityJob.set(wait: 2.minutes).perform_later
  end
end
