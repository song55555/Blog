Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  scope :api, defaults: { format: :json } do
    devise_scope :user do
      post '/users/sign_in', to: 'users/sessions#create'
      delete '/users/sign_out', to: 'users/sessions#destroy'
      post '/users', to: 'users/registrations#create'
    end
    
    resources :users, only: [:update, :destroy], controller: 'users/registrations'
    resources :posts, path: '/posts'
    resources :categories, path: '/categories' do
      resources :posts, only: [:index], path: '/posts'
    end
    resources :tags, path: '/tags' do
      resources :posts, only: [:index], path: '/posts'
    end
  end

  get '/api/posts', to: 'posts#index'
  get '/api/categories', to: 'categories#index'
  get '/api/tags', to: 'tags#index'
end