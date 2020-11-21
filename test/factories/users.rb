FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    sequence(:email) { |n| "tama#{n}@example.com"}
    password {"oooooo"}
  end
end
