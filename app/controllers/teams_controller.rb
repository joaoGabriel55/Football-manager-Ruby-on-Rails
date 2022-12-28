# frozen_string_literal: true

class TeamsController < ActionController::API
  def index
    render json: Team.all
  end

  def team_players
    render json: Player.where(team_id: params[:team_id])
  end

  def create
    team = Team.new(team_params)

    begin
      team.save!

      render json: team, status: :created
    rescue StandardError => e
      render json: { message: e }, status: :bad_request
    end
  end

  def update
    team = Team.find(params[:id])
    team.update!(team_params)

    render json: team, status: :ok
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  def destroy
    team = Team.find(params[:id])

    team.destroy!

    render json: {}, status: :no_content
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  private

  def team_params
    params.permit(%i[name stadium foundation])
  end
end
