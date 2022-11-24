FactoryBot.define do
  positions = ["Goalkeeper", "Defender", "Middle-field", "Forward"]

  factory :fake_player, class: Player do
    name { Faker::Name.unique.name }
    age { Faker::Number.between(from: 16, to: 52) }
    position { positions.sample }
    overall { Faker::Number.between(0, 99) }
  end
end
