# rails3-jquery-autocomplete

An easy way to use jQuery's autocomplete with Rails 3. You can find a [detailed example](http://github.com/crowdint/rails3-jquery-autocomplete-app) 
on how to use this gem [here](http://github.com/crowdint/rails3-jquery-autocomplete-app).

## Before you start

Make sure your project is using jQuery-ui with the autocomplete widget
before you continue.

You can find more info about that here:

* http://jquery.com/
* http://jqueryui.com/demos/autocomplete/
* http://github.com/rails/jquery-ujs

I'd encourage you to understand how to use those 3 amazing tools before attempting to use this gem.

## Installing

Include the gem on your Gemfile

    gem 'rails3-jquery-autocomplete', '0.3.0'

Install it

    bundle install

Run the generator

    rails generate autocomplete
    
And include autocomplete-rails.js on your layouts

    javascript_include_tag "autocomplete-rails.js"

## Upgrading from 0.2.x

If you are upgrading from a previous version, run the generator after installing to replace the javascript file.

    rails generate autocomplete

## Usage

### Model Example

Assuming you have a Brand model:

    class Brand < ActiveRecord::Base
    end

    create_table :brand do |t|
      t.column :name, :string
    end

### Controller

To set up the required action on your controller, all you have to do is call it with the class name and the method
as in the following example:

    class ProductsController < Admin::BaseController
      autocomplete :brand, :name
    end

This will create an action _autocomplete_brand_name_ on your controller, don't forget to add it on your routes file

    resources :products do
      get :autocomplete_brand_name, :on => :collection
    end

### Options

#### :full => true

By default, the search starts from the beginning of the string you're searching for. If you want to do a full search, set the _full_ parameter to true.

    class ProductsController < Admin::BaseController
      autocomplete :brand, :name, :full => true
    end

The following terms would match the query 'un':

* Luna
* Unacceptable
* Rerun

#### :full => false (default behavior)

Only the following terms mould match the query 'un':

* Unacceptable

#### :display_value

If you want to display a different version of what you're looking for, you can use the :display_value option.

This options receives a method name as the parameter, and that method will be called on the instance when displaying the results.

    class Brand < ActiveRecord::Base
      def funky_method
        "#{self.name}.camelize"
      end
    end


    class ProductsController < Admin::BaseController
      autocomplete :brand, :name, :display_value => :funky_method
    end

In the example above, you will search by _name_, but the autocomplete list will display the result of _funky_method_

This wouldn't really make much sense unless you use it with the :id_element HTML tag. (See below)

### View

On your view, all you have to do is include the attribute autocomplete on the text field
using the url to the autocomplete action as the value.
    form_for @product do |f|
      f.text_field :brand_name, :autocomplete => autocomplete_brand_name_products_path
    end

This will generate an HTML tag that looks like:

    <input type="text" data-autocomplete="products/autocomplete_brand_name">

Now your autocomplete JS code is unobtrusive, Rails 3 style.

### Getting the object id

If you need to use the id of the selected object, you can use the *:id_element* HTML tag too:

    f.text_field :brand_name, :autocomplete => autocomplete_brand_name_products_path, :id_element => '#some_element'

This will update the field with id *#some_element with the id of the selected object. The value for this option can be any jQuery selector.

## Development

If you want to make changes to the gem, first install bundler 1.0.0:

    gem install bundler

And then, install all your dependencies:

    bundle install

### Running the test suite

    rake test

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico. 
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!