require "test_helper"
require 'test_controller'
require 'support/mongoid'

class MonogidControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::Test::Setup
  include Rails3JQueryAutocomplete::Test
end
