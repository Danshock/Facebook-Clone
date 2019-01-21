Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :posts

  # TODO Devise unauthurised, authurised paths
end
