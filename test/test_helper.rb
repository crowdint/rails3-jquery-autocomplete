require 'rubygems'
require 'bundler/setup'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] = "test"

require 'rails/all'
require 'mongoid'
require 'mongo_mapper'
require 'shoulda'
require 'rr'
require 'rails/test_help'
require 'rails3-jquery-autocomplete'
require 'yajl/json_gem'

module Rails3JQueryAutocomplete
  class Application < Rails::Application
  end
end

Rails3JQueryAutocomplete::Application.routes.draw do
  match '/:controller(/:action(/:id))'
end

ActionController::Base.send :include, Rails3JQueryAutocomplete::Application.routes.url_helpers

ActorsController = Class.new(ActionController::Base)
ActorsController.autocomplete(:movie, :name)

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

# ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
# ::ActiveRecord::Schema.define(:version => 1) do
  # create_table :movies do |t|
    # t.column :name, :string
  # end
# end

class Dog < ActiveRecord::Base ; end
