Thememy::Application.routes.draw do

  devise_for :users, path: 'account', path_names: { sign_in: 'login', sign_out: 'logout' }, skip: :registrations do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'account',
      controller: 'registrations',
      as: :user_registration do
        get :cancel
      end
  end

  root :to => 'home#index'

end
