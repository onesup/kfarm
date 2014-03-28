Kfarm::Application.routes.draw do
  get 'test_users/index'

  #메인 sub navigation
  get "faq/index"
  get "home/guide" => "home#guide"
  #해당 role별 route
  match 'admin' => 'admin/dashboard#index', :via => :get, :as => "admin"
  match 'mentor' => 'mentor/jobs#index', :via => :get, :as => "mentor"
  
  resources :jobs do
    member do
      get 'join'
      get 'today_jobs'
    end
  end
  
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" } do
  end
  
  resources :users do
    member do
      get 'current_works'
    end
  end
    
  namespace :admin do
    resources :answers
    resources :jobs
    resources :notices
    resources :questions
    resources :reviews
    resources :users
    resources :banners
  end
  
  namespace :mentor do
    resources :answers
    resources :jobs
    resources :notices
    resources :questions
    resources :reviews
    resources :users, :only => [:show, :edit, :update, :destroy] do
      member do
        get 'password'
      end
    end
    resources :banners
  end
  
  resources :faq, :only => [:index]
  resources :reviews, :only => [:index, :show, :new, :create]
  resources :notices, :only => [:index, :show]
  resources :answers, :only => [:index, :show]
  resources :questions
  
  root :to => "home#index"
end