# rails3-jquery-autocomplete

An easy way to use jQuery's autocomplete with Rails 3

## Before you start

Make sure your project is using jQuery-ui with the autocomplete widget
before you continue.

You can find more info about that here:

* http://jquery.com/
* http://jqueryui.com/demos/autocomplete/
* http://github.com/rails/jquery-ujs

I'd recommend you understand what's happening with those 3 tools before attempting to use this gem.

## Installing

Include the gem on your Gemfile

    gem 'rails3-jquery-autocomplete', '>= 0.1.1', :require => 'autocomplete'

Install it

    bundle install

Run the generator

    rails generate autocomplete
    
And include autocomplete-rails.js on your layouts

  javascript_include_tag "autocomplete-rails.js"

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
    form_for @product do |f|
      f.text_field :brand_name, :autocomplete => autocomplete_brand_name_products_path
    end

This will generate an HTML tag that looks like:

    <input type="text" autocomplete="products/autocomplete_brand_name">

Now your autocomplete JS code is unobtrusive, Rails 3 style.

And... That's it!

## TODO

Tests