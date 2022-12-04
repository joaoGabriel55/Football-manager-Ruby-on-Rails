Rails.application.routes.draw do
  scope :api do
    resources :players
    put "players/:id/team" => "players#join_to_team", as: :join_to_team

    resources :teams
    resources :championships
  end
end
