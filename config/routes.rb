Rails.application.routes.draw do

  use_doorkeeper do
    #Just wanted the tokens controller
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  root 'pages#index'

  resources :clients, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :brochure_racks, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :mass_stockings, only: [:new, :create]
  end

  resources :takeaways, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :placements, only: [:new, :create, :show] do
    resources :stockings, only: [:new, :create]
  end

  resources :stockings, only: [:edit, :update, :destroy]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :brochure_racks, only: [:index, :show]
    end
  end
end
