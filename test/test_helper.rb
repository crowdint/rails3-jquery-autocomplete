require 'test/unit'
require 'rubygems'
gem 'rails', '>=3.0.0.rc'
gem 'sqlite3-ruby'


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "active_support"
require "action_controller"
require 'shoulda'
require 'redgreen'
require 'rails3-jquery-autocomplete'

class ApplicationController < ActionController::Base; end

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')

Rails3JQueryAutocomplete::Routes = ActionDispatch::Routing::RouteSet.new
Rails3JQueryAutocomplete::Routes.draw do |map|
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action'
end

ActionController::Base.send :include, Rails3JQueryAutocomplete::Routes.url_helpers

class ActiveSupport::TestCase
  setup do
    @routes = Rails3JQueryAutocomplete::Routes
  end
end
