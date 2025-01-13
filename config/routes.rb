Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
   }

  get 'home/top'
  get 'home/show'

  root to: "home#top"
  resources :posts, only: [:new, :create, :show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end