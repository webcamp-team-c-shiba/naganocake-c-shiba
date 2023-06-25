Rails.application.routes.draw do

  root to:'public/homes#top'
  get 'about' => 'public/homes#about'
  get "search" => "searches#search", as: "search"
  
  
  scope module: :public do
    post 'orders/check' => 'orders#check'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]
    
    resources :addresses, except: [:show]
    
    resource :customers, only: [:show, :edit, :update]
    get 'customers/check' => "customers#check"
    patch 'customers/withdrawal' => "customers#withdrawal"
    
    resources :items, only: [:index,:show]
    get 'genres/search' => 'genres#search'
    
    resources :cart_items, only: [:index,:create,:destroy,:update] do
      delete 'destroy_all', on: :collection
    end
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update] 
    resources :orders, only: [:show, :update]
    get '/orders/:customer_id/index', to: 'orders#customer_index', as: 'customer_orders'
    resources :order_items, only: [:update]
  end
  
  devise_for :admin, skip: [:passwords] , controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
