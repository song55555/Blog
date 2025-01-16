Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  devise_scope :user do
    post '/api/users/sign_in', to: 'users/sessions#create'
    delete '/api/users/sign_out', to: 'users/sessions#destroy'
  end
  
  resources :users, only: [:update, :destroy], controller: 'users/registrations'

  get '/api/posts', to: 'posts#index'
  get '/api/categories', to: 'categories#index'
  get '/api/tags', to: 'tags#index'

  resources :posts, path: '/api/posts'
  resources :categories, path: '/api/categories' do
    resources :posts, only: [:index], path: '/api/posts'
  end
  resources :tags, path: '/api/tags' do
    resources :posts, only: [:index], path: '/api/posts'
  end
end