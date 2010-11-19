require "test_helper"
require 'test_controller'
require 'support/active_record'

class ActiveRecordControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::Test::Setup
  include Rails3JQueryAutocomplete::Test
end
