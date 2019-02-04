Rails.application.routes.draw do
    
    get '/home', to: 'home#index'

    devise_scope :user do
        root to: "devise/registrations#new"
    end

    authenticated :user do
        root 'home#index', as: :authenticated_root
    end

    devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
    resources :users, only: [:index, :show]

    # Nesting the likes resource inside the posts' resource
    resources :posts do
    	resources :likes,	 only: [:create, :destroy]
    	resources :comments, only: [:create, :index, :destroy]
    end
end
