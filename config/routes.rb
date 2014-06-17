Rails.application.routes.draw do
 
  root 'pages#index'
  resources :clients, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
end
