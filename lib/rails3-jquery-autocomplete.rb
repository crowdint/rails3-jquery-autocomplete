require 'rails3-jquery-autocomplete/form_helper'
require 'rails3-jquery-autocomplete/autocomplete'
require 'rails3-jquery-autocomplete/controller'

module Rails3JQueryAutocomplete
  autoload :Orm              , 'rails3-jquery-autocomplete/orm'

  unless ::Rails.version < "3.1"
    require 'rails3-jquery-autocomplete/rails/engine'
  end
end

class ActionController::Base
  include Rails3JQueryAutocomplete::Autocomplete
end
