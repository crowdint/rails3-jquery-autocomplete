require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/autocomplete'

module Rails3JQueryAutocomplete
  autoload :Orm              , 'rails3-jquery-autocomplete/orm'
  autoload :FormtasticPlugin , 'rails3-jquery-autocomplete/formtastic_plugin'

  unless ::Rails.version < "3.1"
    require 'rails3-jquery-autocomplete/rails/engine'
  end
end

class ActionController::Base
  include Rails3JQueryAutocomplete::Autocomplete
end

require 'rails3-jquery-autocomplete/formtastic'

begin
  require 'simple_form'
  require 'rails3-jquery-autocomplete/simple_form_plugin'
rescue LoadError
end
