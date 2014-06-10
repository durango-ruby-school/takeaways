Rails.application.routes.draw do
 
  root 'pages#index'
  resources :brochure_racks, only: [:index, :new, :create, :show, :edit]
end
