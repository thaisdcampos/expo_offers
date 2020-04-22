# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @offers = Offer.enabled.order('premium DESC')
  end
end
