Rails.application.routes.draw do
  resources :inventory_items
  resources :items
  resources :survivors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
