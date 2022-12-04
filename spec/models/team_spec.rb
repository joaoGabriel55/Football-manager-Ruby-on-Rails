require "rails_helper"

RSpec.describe Team, type: :model do
  context "validate Team" do
    it "invalid foundation" do
      expect(Team.new(name: "Barça", stadium: "Camp Nou", foundation: 1200).valid?).to be_falsey

      next_year = Date.today.year + 1

      expect(Team.new(name: "Barça", stadium: "Camp Nou", foundation: next_year).valid?).to be_falsey
    end
  end
end
