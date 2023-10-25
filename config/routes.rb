Rails.application.routes.draw do
  resources :tickets
  root "tickets#index"
  post '/api/create', to: 'api#create'
end
