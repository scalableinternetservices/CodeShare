Rails.application.routes.draw do
  resources :comments
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    root 'posts#index'
  	get 'register', to: 'devise/registrations#new'
  	get 'login', to: 'devise/sessions#new'
  	get 'index', to: 'pages#index'
    get 'profile', to: 'users#show'
  end

  # Avatar routes
  get "avatar/:size/:background/:text" => Dragonfly.app.endpoint { |params, app|
    app.generate(:initial_avatar, URI.unescape(params[:text]), { size: params[:size], background_color: params[:background] })
  }, as: :avatar
  
end
