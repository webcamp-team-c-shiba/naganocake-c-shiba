Rails.application.routes.draw do
  
  scope module: :public do
    resources :addresses, except: [:show]
    resource :customers, only: [:show, :edit, :update]
    get 'customers/check' => "customers#check"
    patch 'customers/withdrawal' => "customers#withdrawal"
  end

  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    get '/' => 'homes#top'
  end
  
  devise_for :admin, skip: [:passwords] , controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to:'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    resources :items, only: [:index,:show]
    resources :cart_items, only: [:index,:create,:destroy,:update]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end