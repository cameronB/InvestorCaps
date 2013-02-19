InvestorCaps::Application.routes.draw do

  resources :users do
    member do
      get :s_following, :s_followers, :c_following
    end
  end

  resources :companies do
    member do
      get :c_followers
    end
  end


  resources :sessions, only: [:new, :create, :destroy]
  resources :s_relationships, only: [:create, :destroy]
  resources :c_relationships, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy]
  resources :comments
  resources :post_votes
  resources :comment_votes, only: [:create, :destroy]

  #home
  root to: 'static_pages#home'

  #(Shareholder) Registration
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  #general
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

end
