require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/helpers'
require 'rails3-jquery-autocomplete/autocomplete'
require 'rails3-jquery-autocomplete/formtastic_plugin'

class ActionController::Base
  extend Rails3JQueryAutocomplete::ClassMethods
  include Rails3JQueryAutocomplete::Helpers
end

#
# Load the formtastic plugin if using Formtastic
#
begin
  require 'formtastic'
  class Formtastic::SemanticFormBuilder < ActionView::Helpers::FormBuilder
    include Rails3JQueryAutocomplete::FormtasticPlugin
  end
rescue LoadError
end