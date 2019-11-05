FactoryBot.define do
  factory :task do
    title   { Faker::Lorem.sentence }
    step_id { FactoryBot.build_stubbed(:step).id }
  end
end
