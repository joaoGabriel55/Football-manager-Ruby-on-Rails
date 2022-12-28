require 'rails_helper'

RSpec.describe PlayersController, type: :request do
  describe 'GET index' do
    let!(:teams) { FactoryBot.create_list(:fake_team, 20) }

    before { get '/api/teams' }

    it 'returns all teams' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET team_players' do
    let!(:players) { FactoryBot.create_list(:fake_player, 1) }
    let!(:teams) { FactoryBot.create_list(:fake_team, 1) }
    let!(:player_id) { players[0].id }
    let!(:team_id) { teams[0].id }

    before do
      JoinToTeam.new(player_id: player_id, team_id: team_id).call

      get "/api/team/#{team_id}/players"
    end

    it 'returns players from a team' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'Successfully' do
      let(:team) do
        {
          name: 'Barça',
          foundation: 1890,
          stadium: 'Nou Camp'
        }
      end

      before { post '/api/teams', params: team }

      it 'returns created team' do
        expect(JSON.parse(response.body)['name']).to eq(team[:name])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'Bad request' do
      let(:player) do
        {
          name: 'Messi',
          age: 15,
          overall: 98,
          position: 'Forward'
        }
      end

      before { post '/api/teams', params: player }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT update' do
    context 'Successfully' do
      let!(:teams) { FactoryBot.create_list(:fake_team, 2) }
      let(:team) do
        {
          id: teams[0].id,
          name: 'Barça',
          foundation: 1890,
          stadium: 'Nou Camp'
        }
      end

      before { put "/api/teams/#{teams[0].id}", params: team }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'Bad request' do
      let!(:teams) { FactoryBot.create_list(:fake_team, 2) }
      let(:team) do
        {
          id: teams[0].id,
          name: 'Barça',
          foundation: 1600,
          stadium: 'Nou Camp'
        }
      end

      before { put "/api/teams/#{teams[0].id}", params: team }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'Successfully' do
      let!(:teams) { FactoryBot.create_list(:fake_team, 2) }

      before { delete "/api/teams/#{teams[0].id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'Bad request' do
      let!(:teams) { FactoryBot.create_list(:fake_player, 2) }

      before { delete '/api/teams/999' }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
