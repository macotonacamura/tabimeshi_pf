FactoryBot.define do
  factory :city do
    city{"Tokyo"}
    country{create(:country)}
  end
end
