Rails.application.routes.draw do
  resources :hashtags, only: [ :index, :show ], param: :name
  resource :session
  resources :passwords, param: :token

  # Posts resources
  resources :posts, except: [ :edit, :update ] do
    member do
      post :like
      delete :unlike
    end
  end

  # Follows resources
  resources :follows, only: [ :create ]
  delete "follows/:user_id", to: "follows#destroy", as: :follow

  # User profiles
  resources :users, only: [ :show, :index ] do
    member do
      get :followers
      get :following
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
