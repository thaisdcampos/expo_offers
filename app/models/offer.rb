class Offer < ApplicationRecord
  URI_FORMAT_VALIDATE = /(https?:\/\/)?(w{3}\.)?(?:[-a-z0-9]+\.)+[a-z]{2,}(\/)?(\?[-A-Za-z0-9+&=_]+)?/

  validates :name, :url, :description, :active_from, presence: true
  validates_uniqueness_of :advertiser_name
  validates :description, length: { maximum: 500 }
  validates :url, format: { with: URI_FORMAT_VALIDATE, on: :create }

  enum status: { disabled: 0, enabled: 1 }
end
