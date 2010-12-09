Integration::Application.routes.draw do
  root :to => 'autocomplete#new'
  match 'autocomplete/autocomplete_brand_name' => 'autocomplete#autocomplete_brand_name'

  resources :products
end
