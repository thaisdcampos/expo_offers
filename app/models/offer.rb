# frozen_string_literal: true

class Offer < ApplicationRecord
  URI_FORMAT_VALIDATE = %r{(https?://)?(w{3}\.)?(?:[-a-z0-9]+\.)+[a-z]{2,}(/)?(\?[-A-Za-z0-9+&=_]+)?}.freeze

  validates :advertiser_name, :url, :description, :active_from, presence: true
  validates_uniqueness_of :advertiser_name
  validates :description, length: { maximum: 500 }
  validates :url, format: { with: URI_FORMAT_VALIDATE, on: :create }
  validate :active_from_valid, on: :create
  validate :active_until_valid, on: :create

  enum status: { disabled: 0, enabled: 1 }, _scopes: true

  before_save :add_url_protocol

  def set_offer_availability
    self.status = enabled? ? :disabled : :enabled
    save!
  end

  private

  def active_from_valid
    if active_from < Date.current
      errors.add(:active_from, 'Can\'t be in the past')
    end
  end

  def active_until_valid
    return unless active_until.present?

    if active_until < Date.current
      errors.add(:active_until, 'Can\'t be in the past')
    end
  end

  def add_url_protocol
    return if  url[%r{\Ahttp://}] || url[%r{\Ahttps://}]

    self.url = "http://#{url}"
  end
end
