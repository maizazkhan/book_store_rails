Rails.application.routes.draw do
  # mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :users
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions' }
      resources :books
    end
  end
end
