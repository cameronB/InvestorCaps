InvestorCaps::Application.routes.draw do
  resources :users
  resources :companies
  resources :sessions, only: [:new, :create, :destroy]

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
