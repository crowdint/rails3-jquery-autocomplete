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

  resources :scoped_autocompletes do
    get :autocomplete_brand_name, :on => :collection
  end
end
#== Route Map
# Generated on 25 Apr 2011 09:55
#
#                                         root        /(.:format)                                             {:controller=>"autocomplete", :action=>"new"}
#         autocomplete_autocomplete_brand_name        /autocomplete/autocomplete_brand_name(.:format)         {:controller=>"autocomplete", :action=>"autocomplete_brand_name"}
#                                     products GET    /products(.:format)                                     {:controller=>"products", :action=>"index"}
#                                              POST   /products(.:format)                                     {:controller=>"products", :action=>"create"}
#                                  new_product GET    /products/new(.:format)                                 {:controller=>"products", :action=>"new"}
#                                 edit_product GET    /products/:id/edit(.:format)                            {:controller=>"products", :action=>"edit"}
#                                      product GET    /products/:id(.:format)                                 {:controller=>"products", :action=>"show"}
#                                              PUT    /products/:id(.:format)                                 {:controller=>"products", :action=>"update"}
#                                              DELETE /products/:id(.:format)                                 {:controller=>"products", :action=>"destroy"}
#          autocomplete_brand_name_id_elements GET    /id_elements/autocomplete_brand_name(.:format)          {:controller=>"id_elements", :action=>"autocomplete_brand_name"}
#                                  id_elements GET    /id_elements(.:format)                                  {:controller=>"id_elements", :action=>"index"}
#                                              POST   /id_elements(.:format)                                  {:controller=>"id_elements", :action=>"create"}
#                               new_id_element GET    /id_elements/new(.:format)                              {:controller=>"id_elements", :action=>"new"}
#                              edit_id_element GET    /id_elements/:id/edit(.:format)                         {:controller=>"id_elements", :action=>"edit"}
#                                   id_element GET    /id_elements/:id(.:format)                              {:controller=>"id_elements", :action=>"show"}
#                                              PUT    /id_elements/:id(.:format)                              {:controller=>"id_elements", :action=>"update"}
#                                              DELETE /id_elements/:id(.:format)                              {:controller=>"id_elements", :action=>"destroy"}
#  autocomplete_foreign_brand_name_sub_classes GET    /sub_classes/autocomplete_foreign_brand_name(.:format)  {:controller=>"sub_classes", :action=>"autocomplete_foreign_brand_name"}
#                                  sub_classes GET    /sub_classes(.:format)                                  {:controller=>"sub_classes", :action=>"index"}
#                                              POST   /sub_classes(.:format)                                  {:controller=>"sub_classes", :action=>"create"}
#                                new_sub_class GET    /sub_classes/new(.:format)                              {:controller=>"sub_classes", :action=>"new"}
#                               edit_sub_class GET    /sub_classes/:id/edit(.:format)                         {:controller=>"sub_classes", :action=>"edit"}
#                                    sub_class GET    /sub_classes/:id(.:format)                              {:controller=>"sub_classes", :action=>"show"}
#                                              PUT    /sub_classes/:id(.:format)                              {:controller=>"sub_classes", :action=>"update"}
#                                              DELETE /sub_classes/:id(.:format)                              {:controller=>"sub_classes", :action=>"destroy"}
#  autocomplete_brand_name_multiple_selections GET    /multiple_selections/autocomplete_brand_name(.:format)  {:controller=>"multiple_selections", :action=>"autocomplete_brand_name"}
#                          multiple_selections GET    /multiple_selections(.:format)                          {:controller=>"multiple_selections", :action=>"index"}
#                                              POST   /multiple_selections(.:format)                          {:controller=>"multiple_selections", :action=>"create"}
#                       new_multiple_selection GET    /multiple_selections/new(.:format)                      {:controller=>"multiple_selections", :action=>"new"}
#                      edit_multiple_selection GET    /multiple_selections/:id/edit(.:format)                 {:controller=>"multiple_selections", :action=>"edit"}
#                           multiple_selection GET    /multiple_selections/:id(.:format)                      {:controller=>"multiple_selections", :action=>"show"}
#                                              PUT    /multiple_selections/:id(.:format)                      {:controller=>"multiple_selections", :action=>"update"}
#                                              DELETE /multiple_selections/:id(.:format)                      {:controller=>"multiple_selections", :action=>"destroy"}
#      autocomplete_feature_name_nested_models GET    /nested_models/autocomplete_feature_name(.:format)      {:controller=>"nested_models", :action=>"autocomplete_feature_name"}
#                                nested_models GET    /nested_models(.:format)                                {:controller=>"nested_models", :action=>"index"}
#                                              POST   /nested_models(.:format)                                {:controller=>"nested_models", :action=>"create"}
#                             new_nested_model GET    /nested_models/new(.:format)                            {:controller=>"nested_models", :action=>"new"}
#                            edit_nested_model GET    /nested_models/:id/edit(.:format)                       {:controller=>"nested_models", :action=>"edit"}
#                                 nested_model GET    /nested_models/:id(.:format)                            {:controller=>"nested_models", :action=>"show"}
#                                              PUT    /nested_models/:id(.:format)                            {:controller=>"nested_models", :action=>"update"}
#                                              DELETE /nested_models/:id(.:format)                            {:controller=>"nested_models", :action=>"destroy"}
#       autocomplete_feature_name_simple_forms GET    /simple_forms/autocomplete_feature_name(.:format)       {:controller=>"simple_forms", :action=>"autocomplete_feature_name"}
#                                 simple_forms GET    /simple_forms(.:format)                                 {:controller=>"simple_forms", :action=>"index"}
#                                              POST   /simple_forms(.:format)                                 {:controller=>"simple_forms", :action=>"create"}
#                              new_simple_form GET    /simple_forms/new(.:format)                             {:controller=>"simple_forms", :action=>"new"}
#                             edit_simple_form GET    /simple_forms/:id/edit(.:format)                        {:controller=>"simple_forms", :action=>"edit"}
#                                  simple_form GET    /simple_forms/:id(.:format)                             {:controller=>"simple_forms", :action=>"show"}
#                                              PUT    /simple_forms/:id(.:format)                             {:controller=>"simple_forms", :action=>"update"}
#                                              DELETE /simple_forms/:id(.:format)                             {:controller=>"simple_forms", :action=>"destroy"}
# autocomplete_brand_name_scoped_autocompletes GET    /scoped_autocompletes/autocomplete_brand_name(.:format) {:controller=>"scoped_autocompletes", :action=>"autocomplete_brand_name"}
#                         scoped_autocompletes GET    /scoped_autocompletes(.:format)                         {:controller=>"scoped_autocompletes", :action=>"index"}
#                                              POST   /scoped_autocompletes(.:format)                         {:controller=>"scoped_autocompletes", :action=>"create"}
#                      new_scoped_autocomplete GET    /scoped_autocompletes/new(.:format)                     {:controller=>"scoped_autocompletes", :action=>"new"}
#                     edit_scoped_autocomplete GET    /scoped_autocompletes/:id/edit(.:format)                {:controller=>"scoped_autocompletes", :action=>"edit"}
#                          scoped_autocomplete GET    /scoped_autocompletes/:id(.:format)                     {:controller=>"scoped_autocompletes", :action=>"show"}
#                                              PUT    /scoped_autocompletes/:id(.:format)                     {:controller=>"scoped_autocompletes", :action=>"update"}
#                                              DELETE /scoped_autocompletes/:id(.:format)                     {:controller=>"scoped_autocompletes", :action=>"destroy"}
