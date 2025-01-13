Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
   }

  get 'home/top'
  get 'home/show'

  root to: "home#index"
  resources :posts, only: [ :new, :create, :show, :destroy]

end