Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  devise_scope :user do
    namespace :api do
      post 'users/sign_in', to: 'users/sessions#create'
      delete 'users/sign_out', to: 'users/sessions#destroy'
      resources :users, only: [:update, :destroy], controller: 'users/registrations'


      
      get '/posts', to: 'posts#index'
      resources :posts
      resources :categories do
        resources :posts, only: [:index]
      end
      resources :tags do
        resources :posts, only: [:index]
      end
    end
  end
end