Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  get 'users/index'
  get 'users/sign_out'
  resources :users, only: %i[index]

  get '/public_recipes', to: 'recipes#public'

  post '/recipe/:id/toggle_public', to: 'recipes#toggle_public'
  resources :recipes, only: %i[index show new create destroy]
end
