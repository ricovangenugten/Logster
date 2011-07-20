Logster::Application.routes.draw do

  resources :activities

  resources :logs do
    get :autocomplete_activity_description, :on => :collection
  end

  devise_for :users

  root :to => "frontpage#index"
  
end
