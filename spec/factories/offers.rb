FactoryBot.define do
  factory :offer do
    advertiser_name { 'Advertiser Name' }
    url { 'http://advertizername.com/' }
    description { "MyString" }
    active_from { Date.current }
    active_until { Date.current + 45.days }
    premium { false }
    status { :disabled }
  end
end
