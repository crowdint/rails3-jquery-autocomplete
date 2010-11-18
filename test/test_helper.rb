require 'test/unit'
require 'rubygems'
gem 'rails', '>=3.0.0.rc'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] = "test"

require 'rails/all'
require 'mongoid'
require 'shoulda'
require 'redgreen'
require 'rails/test_help'
require 'rails3-jquery-autocomplete'

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
