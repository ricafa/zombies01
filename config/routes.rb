Rails.application.routes.draw do
  resources :inventory_items
  resources :items
  resources :survivors
  get '/contaminated/:id', to: 'survivors#contaminated'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
