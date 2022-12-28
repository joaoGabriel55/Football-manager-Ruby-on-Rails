# frozen_string_literal: true

class PlayersController < ActionController::API
  def index
    render json: Player.all # Ask for help!
  end

  def create
    player = Player.new(player_params)

    begin
      player.save!

      render json: player, status: :created
    rescue StandardError => e
      render json: { message: e }, status: :bad_request
    end
  end

  def update
    player = Player.find(params[:id])
    player.update!(player_params)

    render json: player, status: :ok
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  def join_to_team
    player = JoinToTeam.new(player_id: params[:id], team_id: params[:team_id]).call

    render json: { plays_for: player.plays_for }, status: :ok
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  def destroy
    player = Player.find(params[:id])

    player.destroy!

    render json: {}, status: :no_content
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  private

  def player_params
    params.permit(%i[name age position overall])
  end
end
