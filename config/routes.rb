NwkmGriffins::Application.routes.draw do
  resources :users
  resources :players
  resources :teams
  resources :divisions
  resources :seasons
  resources :competitions
  resources :sessions, only: [:new, :create, :destroy]
  resources :player_imports, only: [:new, :create]
  resources :invoices
  resources :transactions

  root to: 'static_pages#home'

  match '/reports/financial',  to: 'reports#financial'  , as: :financial_report
  match '/reports/membership', to: 'reports#membership' , as: :membership
  match '/reports/uniform_numbers', to: 'reports#uniform_numbers' , as: :uniform_numbers
  
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
end
