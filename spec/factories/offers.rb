FactoryBot.define do
  factory :offer do
    name { "MyString" }
    url { "MyString" }
    description { "MyString" }
    active_from { "2020-04-16 08:50:59" }
    active_until { "2020-04-16 08:50:59" }
    premium { false }
    visible { false }
  end
end
