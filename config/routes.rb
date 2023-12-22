Rails.application.routes.draw do
  get 'categories/new'
  get 'categories/create'
  get 'categories/destroy'
  get 'tags/new'
  get 'tags/create'
  get 'tags/destroy'
  get 'comments/new'
  get 'comments/create'
  get 'comments/destroy'
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/create'
  get 'posts/destroy'
  root 'pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
