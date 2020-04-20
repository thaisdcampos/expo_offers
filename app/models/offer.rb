class Offer < ApplicationRecord
  URI_FORMAT_VALIDATE = /(https?:\/\/)?(w{3}\.)?(?:[-a-z0-9]+\.)+[a-z]{2,}(\/)?(\?[-A-Za-z0-9+&=_]+)?/

  validates :advertiser_name, :url, :description, :active_from, presence: true
  validates_uniqueness_of :advertiser_name
  validates :description, length: { maximum: 500 }
  validates :url, format: { with: URI_FORMAT_VALIDATE, on: :create }
  validate :active_from_valid, on: :create
  validate :active_until_valid, on: :create

  enum status: { disabled: 0, enabled: 1 }, _scopes: true

  before_save :add_url_protocol

  def set_offer_availability
    return if correct_status?

    self.status = self.enabled? ? :disabled : :enabled
    self.save!
  end

  private

  def correct_status?
    if self.active_until.present? && Time.current <= self.active_until
      disabled?
    elsif Time.current >= self.active_from
      enabled?
    end
  end

  def active_from_valid
    if self.active_from.past?
      errors.add(:active_from, 'Can\'t be in the past')
    end
  end

  def active_until_valid
    return unless self.active_until.present?

    if self.active_until.past?
      errors.add(:active_until, 'Can\'t be in the past')
    end
  end

  def add_url_protocol
    return if  self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
    self.url = "http://#{self.url}"
  end
end
