FactoryBot.define do
  factory :board do
    title { Faker::Lorem.sentence }
  end
end
