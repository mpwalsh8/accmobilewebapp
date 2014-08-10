Rails.application.routes.draw do
  resources :athletes_teams

  resources :coaches_teams

  resources :sports_venues

  resources :coaches

  resources :teams

  resources :athletes

  resources :venues

  resources :sports

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
