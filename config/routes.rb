Scoreboard::Application.routes.draw do
  root to: 'boards#index'

  post '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', as: :signout
  
  resources :boards
  resources :users do
    member do
      get :accept_terms
    end
  end
  resources :tasks do
    collection do
      post :complete, action: "complete_by_encrypted_package"
    end

    member do
      post :solve
      get :complete, action: "complete_by_signature"
    end
  end

  get '/credits', to: 'credits#index'
  get '/tutorial', to: 'tutorial#index'
  get '/rules', to: 'rules#index'
  get '/terms_and_conditions', to: 'rules#terms_and_conditions'
  
  namespace :admin do
    resources :tasks do
      collection {post :sort}
    end
    resources :scores do
      member do
        put :approve
        put :deny
      end
      collection do
        get :recalculate_scores
        get :remove_duplicates
      end
    end
    resources :users do
      member do
        get :tasks
        get :history
        put :freeze
        put :unfreeze
        post :award_points
        post :complete_task
      end
    end
    get '/reports', to: 'reports#index'
    get '/reports/task_completion', to: 'reports#task_completion'
    get '/reports/task_details', to: 'reports#task_details'
    get '/reports/player_timelines', to: 'reports#player_timelines'
    get '/reports/player_details', to: 'reports#player_details'
    get '/reports/points_awarded', to: 'reports#points_awarded'
    get '/reports/unique_logins', to: 'reports#unique_logins'
    get '/reports/mailing_list', to: 'reports#mailing_list'
    post '/tutorial/change', to: 'tutorial#change'
  end

  get "/:page", to: "static#show", as: "static"
end
