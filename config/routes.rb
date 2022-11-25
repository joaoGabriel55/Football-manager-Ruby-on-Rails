Rails.application.routes.draw do
  scope :api do
    resources :players
    resources :teams
    resources :championships
  end
end
