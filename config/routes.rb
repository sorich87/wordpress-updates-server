ThemeMy::Application.routes.draw do

  resources :customers do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :themes do
    collection do
      post 'validate_zip', as: :validate_zip
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

  resource :home, only: [:index] do
    match 'sorry' => 'home#sorry'
    get '/sorry', :to => :sorry
  end

  root :to => 'home#index'

end
