Integration::Application.routes.draw do
  get "id_elements/new"

  root :to => 'autocomplete#new'
  match 'autocomplete/autocomplete_brand_name' => 'autocomplete#autocomplete_brand_name'

  resources :products
  resources :id_elements do
    get :autocomplete_brand_name, :on => :collection
  end
end
