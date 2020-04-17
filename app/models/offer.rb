class Offer < ApplicationRecord
  validates :name, :url, :description, :active_from, presence: true

  enum status: { disabled: 0, enabled: 1 }
end
