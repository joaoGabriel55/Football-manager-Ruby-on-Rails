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

  describe "POST create" do
    let(:player) {
      {
        name: "Messi",
        age: 17,
        overall: 98,
        position: "Forward",
      }
    }

    before { post "/api/players", params: player }

    it "returns created player" do
      expect(JSON.parse(response.body)["name"]).to eq("Messi")
    end

    it "returns status code 201" do
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT update" do
    let!(:players) { FactoryBot.create_list(:fake_player, 2) }
    let(:player) {
      {
        id: players[0].id,
        name: "Messi",
        age: 17,
        overall: 98,
        position: "Forward",
      }
    }

    before { put "/api/players/#{players[0].id}", params: player }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE destroy" do
    let!(:players) { FactoryBot.create_list(:fake_player, 2) }

    before { delete "/api/players/#{players[0].id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(:no_content)
    end
  end
end
