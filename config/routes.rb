Labgrind::Application.routes.draw do

  resources :items do
    resources :annotations
  end

  resources :labs do
    resources :items
  end

  resources :users, :user_sessions, :skills
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'inventory' => 'items#index'
  match "/inventory/:id" => 'items#show'
  match "/administrators/:id" => 'users#show'

  ActionController::Routing::Routes.draw do |map|
    map.namespace :admin do |admin|
      admin.resources :users
    end
  end

end
