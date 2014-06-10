Rails.application.routes.draw do
 
  root 'pages#index'
  resources :brochure_racks, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :clients, only: [:index, :new, :create, :show]
end
