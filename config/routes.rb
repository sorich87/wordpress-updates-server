ThemeMy::Application.routes.draw do
  resources :customers
  namespace :settings do
    root :to => 'businesses#edit'

    resource :business do
      get '/', :to => :edit
    end
  end
end
