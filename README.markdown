# rails3-jquery-autocomplete

An easy way to use jQuery's autocomplete with Rails 3.

In now supports both ActiveRecord and [mongoid](http://github.com/mongoid/mongoid).

It also supports [Formtastic](http://github.com/justinfrench/formtastic)

## ActiveRecord

You can find a [detailed example](http://github.com/crowdint/rails3-jquery-autocomplete-app)
on how to use this gem with ActiveRecord [here](http://github.com/crowdint/rails3-jquery-autocomplete-app).

## MongoID

You can find a [detailed example](http://github.com/crowdint/rails3-jquery-autocomplete-app/tree/mongoid)
on how to use this gem with MongoID [here](http://github.com/crowdint/rails3-jquery-autocomplete-app/tree/mongoid). (Same thing, different branch)

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

    gem 'rails3-jquery-autocomplete'

Install it

    bundle install

Run the generator

    rails generate autocomplete
    
And include autocomplete-rails.js on your layouts

    javascript_include_tag "autocomplete-rails.js"

## Upgrading from older versions

If you are upgrading from a previous version, run the generator after installing to replace the javascript file.

    rails generate autocomplete

I'd recommend you do this every time you update to make sure you have the latest JS file.

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
      f.autocomplete_field :brand_name, autocomplete_brand_name_products_path
    end

This will generate an HTML tag that looks like:

    <input type="text" data-autocomplete="products/autocomplete_brand_name">

If you are not using a FormBuilder (form_for) or you just want to include an autocomplete field without the form, you can use the
*autocomplete_field_tag* helper.

    form_tag 'some/path'
      autocomplete_field_tag 'address', '', address_autocomplete_path, :size => 75
    end

Now your autocomplete code is unobtrusive, Rails 3 style.

### Getting the object id

If you need to use the id of the selected object, you can use the *:id_element* HTML tag too:

    f.autocomplete_field :brand_name, autocomplete_brand_name_products_path, :id_element => '#some_element'

This will update the field with id *#some_element with the id of the selected object. The value for this option can be any jQuery selector.

## Formtastic

If you are using [Formtastic](http://github.com/justinfrench/formtastic), you automatically get the *autocompleted_input* helper on *semantic_form_for*:

    semantic_form_for @product do |f|
      f.autocompleted_input :brand_name, :url => autocomplete_brand_name_path
    end

The only difference with the original helper is that you must specify the autocomplete url using the *:url* option.

# Cucumber

I have created a step to test your autocomplete with Cucumber and Capybara, all you have to do is add the following lines to your *env.rb* file:

    require 'cucumber/autocomplete'
    
Then you'll have access to the following step:

    I choose "([^"]*)" in the autocomplete list

An example on how to use it:

    @javascript
    Scenario: Autocomplete
      Given the following brands exists:
        | name  |
        | Alpha |
        | Beta  |
        | Gamma |
      And I go to the home page
      And I fill in "Brand name" with "al"
      And I choose "Alpha" in the autocomplete list
      Then the "Brand name" field should contain "Alpha"

I have only tested this using Capybara, no idea if it works with something else, to see it in action, check the [example app](http://github.com/crowdint/rails3-jquery-autocomplete-app).

# Development

If you want to make changes to the gem, first install bundler 1.0.0:

    gem install bundler

And then, install all your dependencies:

    bundle install

## Running the test suite

You need to have an instance of MongoDB running on your computer or all the mongo tests will fail miserably.

    rake test

# Changelog

* 0.5.1 Add STI support
* 0.5.0 Formtastic support
* 0.4.0 MongoID support
* 0.3.6 Using .live() to put autocomplete on dynamic fields

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico. 
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!
