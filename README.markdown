# rails3-jquery-autocomplete

An easy way to use jQuery's autocomplete with Rails 3.

Supports both ActiveRecord, [mongoid](http://github.com/mongoid/mongoid), and [MongoMapper](https://github.com/jnunemaker/mongomapper).

Works with [Formtastic](http://github.com/justinfrench/formtastic)
and [SimpleForm](https://github.com/plataformatec/simple_form)

## ActiveRecord

You can find a [detailed example](http://github.com/crowdint/rails3-jquery-autocomplete-app)
on how to use this gem with ActiveRecord [here](http://github.com/crowdint/rails3-jquery-autocomplete-app).

## MongoID

You can find a [detailed example](http://github.com/crowdint/rails3-jquery-autocomplete-app/tree/mongoid)
on how to use this gem with MongoID [here](http://github.com/crowdint/rails3-jquery-autocomplete-app/tree/mongoid). (Same thing, different branch)

## MongoMapper

TODO

## Before you start

Make sure your project is using jQuery-UI and the autocomplete widget
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

    rails generate autocomplete:install

And include autocomplete-rails.js on your layouts

    javascript_include_tag "autocomplete-rails.js"

## Upgrading from older versions

If you are upgrading from a previous version, run the generator after installing to replace the javascript file.

    rails generate autocomplete:install

I'd recommend you do this every time you update to make sure you have the latest JS file.

## Uncompressed Javascript file

If you want to make changes to the JS file, you can install the
uncompressed version by running:

    rails generate autocomplete:uncompressed

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

#### :extra_data

By default, your search will only return the required columns from the database needed to populate your form, namely id and the column you are searching (name, in the above example).

Passing an array of attributes/column names to this option will fetch and return the specified data.

    class ProductsController < Admin::BaseController
      autocomplete :brand, :name, :extra_data => [:slogan]
    end

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

Only the object's id and the column you are searching on will be returned in JSON, so if your display_value method requires another parameter, make sure to fetch it with the :extra_data option


#### :scopes
  Added option to use scopes. Pass scopes in an array.
  e.g `:scopes => [:scope1, :scope2]`

#### :column_name
   By default autocomplete uses method name as column name. Now it can be specified using column_name options
   `:column_name => 'name'`

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

### Getting extra object data

If you need to extra data about the selected object, you can use the *:update_elements* HTML attribute.

The :update_elements attribute accepts a hash where the keys represent the object attribute/column data to use to update and the values are jQuery selectors to retrieve the HTML element to update:

    f.autocomplete_field :brand_name, autocomplete_brand_name_products_path, :update_elements => {:id => '#id_element', :slogan => '#some_other_element'}

    class ProductsController < Admin::BaseController
      autocomplete :brand, :name, :extra_data => [:slogan]
    end

The previous example would fetch the extra attribute slogan and update jQuery('#some_other_element') with the slogan value.

### Running custom code on selection

A javascript event named *railsAutocomplete.select* is fired on the input field when a value is selected from the autocomplete drop down. If you need to do something more complex than update fields with data, you can hook into this event, like so:

    $('#my_autocomplete_field').bind('railsAutocomplete.select', function(){ /* Do something here */});

## Formtastic

If you are using [Formtastic](http://github.com/justinfrench/formtastic), you automatically get the *autocompleted_input* helper on *semantic_form_for*:

    semantic_form_for @product do |f|
      f.autocompleted_input :brand_name, :url => autocomplete_brand_name_products_path
    end

The only difference with the original helper is that you must specify the autocomplete url using the *:url* option.

## SimpleForm

If you want to use it with simple_form, all you have to do is use the
:as option on the input and set the autocomplete path with the :url
option.


    simple_form_for @product do |form|
      form.input :name
      form.input :brand_name, :url => autocomplete_brand_name_products_path, :as => :autocomplete

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

# Steak

I have created a helper to test your autocomplete with Steak and Capybara, all you have to do is add the following lines to your *acceptance_helper.rb* file:

    require 'steak/autocomplete'

Then you'll have access to the following helper:

    choose_autocomplete_result

An example on how to use it:

    scenario "Autocomplete" do
      lambda do 
        Brand.create! [
          {:name => "Alpha"}, 
          {:name => "Beta"},
          {:name => "Gamma"}
        ]
      end.should change(Brand, :count).by(3)

      visit home_page
      fill_in "Brand name", :with => "al"
      choose_autocomplete_result "Alpha"
      find_field("Brand name").value.should include("Alpha")
    end

I have only tested this using Capybara, no idea if it works with something else.

# Development

If you want to make changes to the gem, first install bundler 1.0.0:

    gem install bundler

And then, install all your dependencies:

    bundle install

## Running the test suite

You need to have an instance of MongoDB running on your computer or all the mongo tests will fail miserably.

    rake test

## Integration tests

If you make changes or add features to the jQuery part, please make sure
you write a cucumber test for it.

You can find an example Rails app on the *integration* folder.

You can run the integration tests with the cucumber command while on the
integration folder:

    cd integration
    rake db:migrate
    cucumber

# Thanks to

Everyone on [this list](https://github.com/crowdint/rails3-jquery-autocomplete/contributors)

# About the Author

[Crowd Interactive](http://www.crowdint.com) is an American web design and development company that happens to work in Colima, Mexico.
We specialize in building and growing online retail stores. We don’t work with everyone – just companies we believe in. Call us today to see if there’s a fit.
Find more info [here](http://www.crowdint.com)!

