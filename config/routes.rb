Rails.application.routes.draw do
  get 'purchases/create'

  # mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :users
  resources :bookstores do
    resources :books do
      post 'purchase', to: 'purchases#create', on: :member
    end
  end
  root "welcome#index"

  namespace :admin do
    resources :dashboard
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions' }
      resources :books
      resources :bookstores
    end
  end
end
