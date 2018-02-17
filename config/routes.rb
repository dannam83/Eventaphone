Rails.application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: { format: :json } do
    resources :events, only: [:show, :create, :destroy]
  end

end
