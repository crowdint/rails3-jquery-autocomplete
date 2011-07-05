require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/autocomplete'
require 'rails3-jquery-autocomplete/formtastic_plugin'
require 'rails3-jquery-autocomplete/orm/active_record'
require 'rails3-jquery-autocomplete/orm/mongoid'

class ActionController::Base
  include Rails3JQueryAutocomplete::Autocomplete
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

begin
  require 'simple_form'
  require 'rails3-jquery-autocomplete/simple_form_plugin'
rescue LoadError
end
