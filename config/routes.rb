Rails.application.routes.draw do
    root to: "home#index"
    get '/home', to: 'home#index'
    
    devise_for :users
    
    # Nesting the likes resource inside the posts' resource
    resources :posts do
    	resources :likes
    end
end
