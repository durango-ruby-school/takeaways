Rails.application.routes.draw do

  root 'pages#index'

  resources :clients, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :brochure_racks, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :takeaways, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :placements, only: [:new, :create, :show] do
    resources :stockings, only: [:new, :create]
  end

  resources :stockings, only: [:edit, :update, :destroy]

end
