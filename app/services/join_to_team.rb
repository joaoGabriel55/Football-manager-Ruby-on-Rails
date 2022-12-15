class JoinToTeam
  def initialize(player_id:, team_id:)
    @player = Player.find(player_id)
    @team = Team.find(team_id)
  end

  def call
    @player.update!(team: @team)

    @player
  end
end
