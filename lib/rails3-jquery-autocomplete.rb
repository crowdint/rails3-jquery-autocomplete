require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/helpers'
require 'rails3-jquery-autocomplete/autocomplete'

class ActionController::Base
  extend Rails3JQueryAutocomplete::Autocomplete
end
