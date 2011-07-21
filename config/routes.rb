Logster::Application.routes.draw do

  resources :logs, :except => [:show] do
    get :autocomplete_activity_description, :on => :collection
  end

  devise_for :users

  root :to => "frontpage#index"
  
end
