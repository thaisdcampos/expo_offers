class Offer < ApplicationRecord
  URI_FORMAT_VALIDATE = /(https?:\/\/)?(w{3}\.)?(?:[-a-z0-9]+\.)+[a-z]{2,}(\/)?(\?[-A-Za-z0-9+&=_]+)?/

  validates :advertiser_name, :url, :description, :active_from, presence: true
  validates_uniqueness_of :advertiser_name
  validates :description, length: { maximum: 500 }
  validates :url, format: { with: URI_FORMAT_VALIDATE, on: :create }
  validates :active_from_valid
  validates :active_until_valid

  enum status: { disabled: 0, enabled: 1 }

  def verify_status
    return if correct_status?

    self.status = self.status_enabled? ? :disabled : :enabled?
  end

  private

  def correct_status?
    if Time.current >= self.active_from
      self.status_enabled?
    elsif Time.current <= self.active_until
      self.status_disabled?
    end
  end

  def active_from_valid
    if self.active_from > Time.current
      errors.add(:active_from, 'Couldn\'t an old date')
    end
  end

  def active_until_valid
    return unless self.active_until.present?

    if self.active_until > Time.current
      errors.add(:active_from, 'Couldn\'t an old date')
    end
  end
end
