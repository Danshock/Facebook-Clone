Rails.application.routes.draw do
    root to: "home#index"
    get '/home', to: 'home#index'
    
    devise_for :users
    resources :users, only: [:index, :show]
    
    # Nesting the likes resource inside the posts' resource
    resources :posts do
    	resources :likes,	 only: [:create, :destroy]
    	resources :comments, only: [:create, :index, :destroy]
    end
end
