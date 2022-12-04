FactoryBot.define do
  factory :fake_team, class: Team do
    name { Faker::Name.unique.name }
    foundation { Faker::Number.between(from: 1700, to: Date.today.year) }
    stadium { Faker::Name.unique.name }
  end

  positions = ["Goalkeeper", "Defender", "Middle-field", "Forward"]

  factory :fake_player, class: Player do
    name { Faker::Name.unique.name }
    age { Faker::Number.between(from: 16, to: 52) }
    position { positions.sample }
    overall { Faker::Number.between(from: 1, to: 99) }
  end
end
