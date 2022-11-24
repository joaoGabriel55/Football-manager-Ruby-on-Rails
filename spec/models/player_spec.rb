require "rails_helper"

RSpec.describe Player, type: :model do
  context "validate Player" do
    it "invalid age" do
      expect(Player.new(name: "Lionel", age: 15, position: "Forward", overall: 98).valid?).to be_falsey
    end

    it "invalid overall" do
      expect(Player.new(name: "Lionel", age: 17, position: "Forward", overall: 0).valid?).to be_falsey
    end
  end
end
