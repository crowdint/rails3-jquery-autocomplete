Integration::Application.routes.draw do

  root :to => 'autocomplete#new'
  match 'autocomplete/autocomplete_brand_name' => 'autocomplete#autocomplete_brand_name'

  resources :products
  resources :id_elements do
    get :autocomplete_brand_name, :on => :collection
  end

  resources :sub_classes do
    get :autocomplete_foreign_brand_name, :on => :collection
  end

  resources :multiple_selections do
    get :autocomplete_brand_name, :on => :collection
  end

  resources :nested_models do
    get :autocomplete_feature_name, :on => :collection
  end

  resources :simple_forms do
    get :autocomplete_feature_name, :on => :collection
  end
end
