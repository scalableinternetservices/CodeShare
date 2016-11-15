Rails.application.routes.draw do
  resources :photos#, only: [:index, :new, :create]
  resources :comments
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    root 'posts#index'
  	get 'register', to: 'devise/registrations#new'
  	get 'login', to: 'devise/sessions#new'
  	get 'index', to: 'pages#index'
    get 'profile/(:id)', to: 'users#show', as: 'profile'
    get 'edit', to: 'devise/registrations#edit'
  end

  resources :post do 
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end


  # Avatar routes
  get "avatar/:size/:background/:text" => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
  }, as: :avatar
end
