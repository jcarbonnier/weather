Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'rails/up' => 'rails/health#show', as: :rails_health_check

  # Rswag config
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # ActiveRecord API
  namespace :api do
    scope module: 'public' do
      resources :sessions, only: [:create]
      resources :users, only: [:create]
      resources :weather_averages, only: [:index]
    end
    scope module: 'private' do
      resources :users, only: [:show]
      resources :locations, only: [:index]
      resources :weather_locations, only: %i[index show create destroy]
      resources :weather_forecasts, only: %i[index show]
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
