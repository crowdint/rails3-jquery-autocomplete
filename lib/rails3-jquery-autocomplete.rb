require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/helpers'
require 'rails3-jquery-autocomplete/autocomplete'

class ActionController::Base
  extend Rails3JQueryAutocomplete::ClassMethods
  include Rails3JQueryAutocomplete::Helpers
end
