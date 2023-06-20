Rails.application.routes.draw do
  
  scope module: :public do
    get 'orders/check' => 'orders#check'
    get 'orders/complete' => 'orders#complete'
    resource :orders, only: [:new, :create, :index, :show]
    
    resources :addresses, except: [:show]
    
    resources :items, only: [:index,:show]
    resources :cart_items, only: [:index,:create,:destroy,:update]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    
    resource :customers, only: [:show, :edit, :update]
    get 'customers/check' => "customers#check"
    patch 'customers/withdrawal' => "customers#withdrawal"
  end


  
  namespace :admin do
    get '/' => 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
  end
  
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to:'public/homes#top'
  get 'about' => 'public/homes#about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end