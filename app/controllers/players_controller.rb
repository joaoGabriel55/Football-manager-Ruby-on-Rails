class PlayersController < ActionController::API
  def index
    render json: [
      'James',
      'Messi'
    ]
  end
end