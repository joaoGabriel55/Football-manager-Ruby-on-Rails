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
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  def update
    begin
      team = Team.find(params[:id])
      team.update!(team_params)

      render json: team, status: :ok
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  def destroy
    begin
      team = Team.find(params[:id])

      team.destroy!

      render json: {}, status: :no_content
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  private

  def team_params
    params.permit([:name, :stadium, :foundation])
  end
end
