class PagesController < ApplicationController
  def home
    @offers = Offer.enabled
  end
end
