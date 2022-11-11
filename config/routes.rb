Rails.application.routes.draw do
  # welcome
  root 'welcome#index'

  # admin
  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants, only: %i[index create new show edit update]
    resources :invoices, only: %i[index show update]
  end

  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
  get '/merchants/:merchant_id/bulk_discounts', to: 'merchants#show'
  patch 'merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, only: [] do
    resources :items, only: %i[index show edit new create]
    resources :item_status, only: [:update]
    resources :invoices, only: %i[index show update]
    # resources :bulk_discounts, only: [:show]
  end
end
