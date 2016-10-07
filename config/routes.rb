Rails.application.routes.draw do
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
  	get 'register', to: 'devise/registrations#new'
  	get 'login', to: 'devise/sessions#new'
  	get 'feed', to: 'users#feed'

    authenticated :user do
      root 'users#feed', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end
