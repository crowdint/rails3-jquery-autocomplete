# rails3-jquery-autocomplete

An easy way to use jQuery's autocomplete with Rails 3

## Before you start

Make sure your project is using jQuery and you have the Autocomplete plugin installed 
before you continue.

You can find more info here:

* http://jquery.com/
* http://bassistance.de/jquery-plugins/jquery-plugin-autocomplete/
* 

## Usage

### Controller

To set up an action on your controller, all you have to do is call it with the object name and the method
as in the following example:

 class ProductsController < Admin::BaseController
   autocomplete :brand, :name
 end

 This will magically generate an action autocomplete_brand_name, so, 
 don't forget to add it on your routes file

   resources :products do
      get :autocomplete_brand_name, :on => :collection
   end

### View

On your view, all you have to do is include the attribute autocomplete on the text field
using the url to the autocomplete action as the value.

   f.text_field :brand_name, :autocomplete => autocomplete_brand_name_products_path

That's it!