Rails.application.routes.draw do
  resources :inventory_items
  resources :items
  resources :survivors
  get '/contaminated/:id', to: 'survivors#contaminated'
  post '/trade', to: 'inventory_items#trade'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
