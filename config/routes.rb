Rails.application.routes.draw do
  resources :events

  resources :opponents

  resources :athletes_teams

  resources :coaches_teams

  resources :sports_venues

  resources :coaches

  resources :teams

  resources :athletes do
    collection { get :import }
    collection { post :import }
  end

  resources :venues

  resources :sports

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
