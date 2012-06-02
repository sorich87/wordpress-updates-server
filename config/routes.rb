ThemeMy::Application.routes.draw do

  resources :customers do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :themes, only: [:index, :update, :create, :destroy] do
    # Because plupload does not support PUT requests (POST is hardcoded into it)
    member do
      post :update
    end
  end

  namespace :settings do
    root :to => 'businesses#edit'

    resource :business, :only => [:edit, :update, :destroy] do
      get '/', :to => :edit
      get '/admin', :to => :admin
    end

    resources :packages
  end

  devise_for :customers

  devise_for :users, path: 'account', path_names: { sign_in: 'login', sign_out: 'logout' }, skip: :registrations

  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'account',
      controller: 'registrations',
      as: :user_registration do
        get :cancel
      end
  end

  namespace :api do
    namespace :v1 do
      resources :tokens, only: [:create, :destroy]
      resources :sites, only: [:create]
    end
  end

  resource :home, only: [:index] do
    match 'sorry' => 'home#sorry'
    get '/sorry', :to => :sorry
  end

  root :to => 'home#index'

end
