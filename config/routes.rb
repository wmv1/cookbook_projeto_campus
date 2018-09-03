Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]
end
