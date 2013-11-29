require 'rubygems'
require 'bundler/setup'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RAILS_ENV"] = "test"
module Rails
  def self.env
    ActiveSupport::StringInquirer.new("test")
  end
end

require 'rails/all'
require 'mongoid'
require 'mongo_mapper'
require 'shoulda'
require 'rr'
require 'rails/test_help'
require 'rails3-jquery-autocomplete'

module Rails3JQueryAutocomplete
  class Application < ::Rails::Application
  end
end

Rails3JQueryAutocomplete::Application.routes.draw do
  match '/:controller(/:action(/:id))'
end

ActionController::Base.send :include, Rails3JQueryAutocomplete::Application.routes.url_helpers

class Test::Unit::TestCase

end

