Labgrind::Application.routes.draw do

  resources :users do
    resources :skills
    resources :transactions
    resources :items
  end

  resources :items do
    resources :annotations
    resources :transactions
  end

  resources :labs do
    resources :items
  end

  resources :transactions

  resources :user_sessions, :skills

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'inventory' => 'items#index'
  match "/inventory/:id" => 'items#show'
  match "/administrators/:id" => 'users#show'
  match "/transactions/status/:status" => "transactions#bystatus"
  match "/transactions/approve" => "transactions#approve"

  root :to => 'user_sessions#new', :as => :login

  ActionController::Routing::Routes.draw do |map|
    map.namespace :admin do |admin|
      admin.resources :users
    end
  end

end
