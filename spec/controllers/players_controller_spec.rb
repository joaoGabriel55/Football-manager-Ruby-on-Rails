require "rails_helper"

RSpec.describe PlayersController, type: :request do
  describe "GET index" do
    let!(:players) { FactoryBot.create_list(:fake_player, 20) }

    before { get "/api/players" }

    it "returns all players" do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(:success)
    end
  end
end
