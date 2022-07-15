Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :dogs
  resources :likes, only: [:create, :destroy]
  devise_for :users
  root to: "dogs#index"
end
