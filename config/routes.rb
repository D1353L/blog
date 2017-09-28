Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'

  resources :articles
  resources :copyriters, only: %i[new create destroy]
  get 'dashboard', to: 'dashboard#index', as: :dashboard
end
