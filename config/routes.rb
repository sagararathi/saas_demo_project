Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :weather_grid
end
