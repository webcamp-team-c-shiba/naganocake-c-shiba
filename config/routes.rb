Rails.application.routes.draw do
  
  namespace :public do
    # Rails.application.routes.draw do
    # get '/orders/new', to: 'orders#new'
    # end
    # # get 'orders/new' , to: 'orders#new'
    # get 'orders/check' => 'orders#check'
    # get 'orders/complete' => 'orders#complete'
    # get 'orders/create' => 'orders#create'
    # get 'orders/index' => 'orders#index'
    # get 'orders/show' => 'orders#show'
  resources :orders, only: [:new, :check, :complete, :create, :index, :show]
  resources :addresses, except: [:show]
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
