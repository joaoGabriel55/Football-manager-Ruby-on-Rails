class PlayersController < ActionController::API
  def index
    render json: Player.all # Ask for help!
  end

  def create
    player = Player.new(player_params)

    begin
      player.save!

      render json: player, status: :created
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  def update
    begin
      player = Player.find(params[:id])
      player.update!(player_params)

      render json: player, status: :ok
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  def join_to_team
    begin
      player = JoinToTeam.new(player_id: params[:id], team_id: params[:team_id]).call

      render json: { plays_for: player.plays_for }, status: :ok
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  def destroy
    begin
      player = Player.find(params[:id])

      player.destroy!

      render json: {}, status: :no_content
    rescue => exception
      render json: { message: exception }, status: :bad_request
    end
  end

  private

  def player_params
    params.permit([:name, :age, :position, :overall])
  end
end
