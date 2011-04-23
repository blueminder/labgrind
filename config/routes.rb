Labgrind::Application.routes.draw do

  resources :projects do
    resources :project_updates do
      
    end
  end

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

  resources :events

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'inventory' => 'items#index'
  match "/inventory/:id" => 'items#show'
  match "/administrators/:id" => 'users#show'
  match "/transactions/status/:status" => "transactions#bystatus"
  match "/transactions/approve" => "transactions#approve"
  match "/transactions/reject" => "transactions#reject"
  match "/projects/update_entry_title" => "projects#update_entry_title"
  match "/projects/update_entry_content" => "projects#update_entry_content"
  match "/projects/delete_entry" => "projects#delete_entry"
  match "/projects/:project_id/project_updates/:id" => 'project_updates#delete'
  

  root :to => 'user_sessions#new', :as => :login

  ActionController::Routing::Routes.draw do |map|
    map.namespace :admin do |admin|
      admin.resources :users
    end
    map.namespace :lab_admin do |admin|
      admin.resources :users
    end
  end

end
