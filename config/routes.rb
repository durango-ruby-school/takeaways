Rails.application.routes.draw do

  use_doorkeeper do
    #Just wanted the tokens controller
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  root 'pages#index'

  resources :clients

  resources :brochure_racks do
    resources :mass_stockings, only: [:new, :create]
  end

  resources :takeaways do
    member do
      get :restore
    end
  end

  resources :placements, only: [:new, :create, :show, :destroy] do
    resources :stockings, only: [:new, :create]
  end

  resources :stockings, only: [:edit, :update, :destroy]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :brochure_racks, only: [:index, :show] do
        resources :mass_stockings, only: [:create]
      end
    end
  end
end
