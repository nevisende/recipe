Rails.application.routes.draw do
  devise_for :users
  root 'foods#index'
  get 'users/index'
  get 'users/sign_out'
  resources :users, only: %i[index]
  resources :foods, only: %i[index new create destroy]
  resources :recipes, only: %i[index show new create destroy] do
    resources :recipe_foods, only: %i[new create destroy update edit]
    resources :shopping_list, only: %i[index show]
  end
  get '/public_recipes', to: 'recipes#public'
  post 'shopping_list/recipe_id=:recipe_id', to: 'recipes#generate_list', as: 'generate_shopping_list'
  get 'shopping_list/recipe_id=:recipe_id&inventory_id=:inventory_id', to: 'recipes#generate', as: 'shopping_list'
end
