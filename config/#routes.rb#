Labgrind::Application.routes.draw do
  resources :users do
    resources :skills
  end

  resources :items do
    resources :annotations
  end

  resources :labs do
    resources :items
  end

  resources :users, :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'inventory' => 'items#index'
  match "/inventory/:id" => 'items#show'
  match "/administrators/:id" => 'users#show'

  ActionController::Routing::Routes.draw do |map|
    map.resources :administrators
  end

end
