FactoryBot.define do
  factory :step do
    title    { Faker::Lorem.sentence }
    board_id { FactoryBot.build_stubbed(:board).id }
  end
end
