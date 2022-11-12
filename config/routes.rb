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
  get '/merchants/:merchant_id/dashboard/bulk_discounts', to: 'bulk_discounts#index'
  # get '/merchants/:merchant_id/dashboard/bulk_discounts/show', to: 'bulk_discounts#show'
  get '/merchants/:merchant_id/dashboard/bulk_discounts/new', to: 'bulk_discounts#new'
  post '/merchants/:merchant_id/bulk_discounts/create', to: 'bulk_discounts#create'
  delete '/merchants/:merchant_id/dashboard/bulk_discounts/:discount_id/destroy', to: 'bulk_discounts#destroy'
  # patch 'merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, only: [] do
    resources :items, only: %i[index show edit new create]
    resources :item_status, only: [:update]
    resources :invoices, only: %i[index show update]
    resources :bulk_discounts, only: %i[index show create new destroy]
  end
end
