Rails.application.routes.draw do
  resources :sugs
  resources :sugs
  resources :ads
  resources :ads
  match "/results/purge", to: "results#purge", via: [:delete], as: :purge_results
  resources :results do
    collection do
      delete :purge
    end
  end

  match "/events/purge", to: "events#purge", via: [:delete], as: :purge_events
  resources :events do
    collection do
      delete :purge
    end
  end

  resources :opponents

  match "/athlets_teams/purge", to: "athlets_teams#purge", via: [:delete], as: :purge_athlets_teams
  resources :athletes_teams do
    collection do
      get :import
      post :import
      delete :purge
    end
  end

  resources :coaches_teams

  resources :sports_venues

  resources :coaches do
    collection { get :import }
    collection { post :import }
  end

  resources :teams

  match "/athletes/purge", to: "athletes#purge", via: [:delete], as: :purge_athletes
  resources :athletes do
    collection do
      get :import
      post :import
      delete :purge
    end
  end

  resources :venues

  resources :sports

  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/yearbook', :to => redirect('/teams.pdf')
end
