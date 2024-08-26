Rails.application.routes.draw do
  post 'user', to: 'users#create'
  get 'user/:id', to: 'users#show'
  patch 'user/:id', to: 'users#update'
  delete 'user/:id', to: 'users#destroy'

  post 'sku', to: 'skus#create'
  get 'sku/:id', to: 'skus#show'
  patch 'sku/:id', to: 'skus#update'
  delete 'sku/:id', to: 'skus#destroy'

  post 'inventory/:sku_id/:operation', to: 'inventory#operation'

  post 'orders/:operation', to: 'order#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
