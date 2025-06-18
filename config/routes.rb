Rails.application.routes.draw do

  devise_for :users, sign_out_via: [:get, :delete]

  root "dashboard#index"

  resources :transactions
  resources :categories
  resources :budgets
  resources :goals
end
