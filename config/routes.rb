Labgrind::Application.routes.draw do
  resources :items do
    resources :annotations
  end

  resources :labs do
    resources :items
  end

  resources :users, :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
end
