Rails.application.routes.draw do
  root 'boards#index'

  get '/boards'             => 'boards#index',       defaults: {format: :json}
  get '/boards/:id'         => 'boards#show',        defaults: {format: :json}
  put '/boards/:id'         => 'boards#update',      defaults: {format: :json}
  post '/boards'            => 'boards#create'
  delete '/boards/:id'      => 'boards#destroy'

  resources :steps
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'boards#index',    defaults: {format: :json}
end
