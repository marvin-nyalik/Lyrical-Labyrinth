Rails.application.routes.draw do

  get 'notifications/index'
  get '/posts/tags/:tag_name', to: 'posts#tagged', as: 'tagged'
  get '/posts/categories/:category_name', to: 'posts#categorized', as: 'categorized'

  resources :posts, param: :slug do
    resources :comments do
      member do 
        post 'reply_to_comment'
        get 'edit_reply'
        patch 'update_reply'
      end
    end
  end

  resources :notifications, only: [:index]
  resources :tags, only: [:create, :new]
  resources :categories, param: :slug, only: [:create, :new] do
    member do 
      get :edit
      patch :update
    end
  end

  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
