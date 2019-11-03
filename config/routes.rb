Rails.application.routes.draw do
  root 'boards#index'

  get '/boards' => 'boards#index', defaults: { format: :json }

  resources :boards, only: [:show, :create, :update, :destroy]
  resources :steps
  resources :tasks
end
