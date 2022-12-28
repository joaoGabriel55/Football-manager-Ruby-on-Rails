# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlayersController do
  describe 'GET index' do
    let!(:players) { FactoryBot.create_list(:fake_player, 20) }

    before { get '/api/players' }

    it 'returns all players' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'Successfully' do
      let(:player) do
        {
          name: 'Messi',
          age: 17,
          overall: 98,
          position: 'Forward'
        }
      end

      before { post '/api/players', params: player }

      it 'returns created player' do
        expect(JSON.parse(response.body)['name']).to eq(player[:name])
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

      before { post '/api/players', params: player }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT update' do
    context 'Successfully' do
      let!(:players) { FactoryBot.create_list(:fake_player, 2) }
      let(:player) do
        {
          id: players[0].id,
          name: 'Messi',
          age: 17,
          overall: 98,
          position: 'Forward'
        }
      end

      before { put "/api/players/#{players[0].id}", params: player }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'Bad request' do
      let!(:players) { FactoryBot.create_list(:fake_player, 2) }
      let(:player) do
        {
          id: players[0].id,
          name: 'Messi',
          age: 16,
          overall: 98,
          position: 'Forward'
        }
      end

      before { put '/api/players/999', params: player }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['message']).to eq("Couldn't find Player with 'id'=999")
      end
    end
  end

  describe 'PUT join_to_team' do
    context 'Successfully' do
      let!(:players) { FactoryBot.create_list(:fake_player, 1) }
      let!(:teams) { FactoryBot.create_list(:fake_team, 1) }
      let!(:team_id) { { team_id: teams[0].id } }

      before { put "/api/players/#{players[0].id}/team", params: team_id }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns plays for' do
        expect(JSON.parse(response.body)['plays_for']).to eq(teams[0].name)
      end
    end

    context 'Could not find player' do
      let!(:players) { FactoryBot.create_list(:fake_player, 1) }
      let!(:teams) { FactoryBot.create_list(:fake_team, 1) }
      let!(:team_id) { { team_id: teams[0].id } }

      before { put '/api/players/999/team', params: team_id }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['message']).to eq("Couldn't find Player with 'id'=999")
      end
    end

    context 'Could not find team' do
      let!(:players) { FactoryBot.create_list(:fake_player, 1) }
      let!(:teams) { FactoryBot.create_list(:fake_team, 1) }
      let!(:team_id) { { team_id: 999 } }

      before { put "/api/players/#{players[0].id}/team", params: team_id }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)['message']).to eq("Couldn't find Team with 'id'=999")
      end
    end
  end

  describe 'DELETE destroy' do
    context 'Successfully' do
      let!(:players) { FactoryBot.create_list(:fake_player, 2) }

      before { delete "/api/players/#{players[0].id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'Bad request' do
      let!(:players) { FactoryBot.create_list(:fake_player, 2) }

      before { delete '/api/players/999' }

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
