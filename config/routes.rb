Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
   }

  root to: "posts#index"
  resources :posts, only: [ :new, :create, :show, :destroy, :edit, :update]
  resources :categories, only: [:show]
  resources :tags, only: [:show]

end