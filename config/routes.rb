Rails.application.routes.draw do
  get "goals/index"
  get "goals/new"
  get "goals/create"
  get "goals/edit"
  get "goals/update"
  get "goals/destroy"
  get "categories/index"
  get "categories/new"
  get "categories/create"
  get "categories/edit"
  get "categories/update"
  get "categories/destroy"

  devise_for :users, sign_out_via: [:get, :delete]

  root "dashboard#index"

  resources :transactions
  resources :categories
  resources :budgets
  resources :goals
end
