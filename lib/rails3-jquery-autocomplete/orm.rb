module Rails3JQueryAutocomplete
  module Orm
    autoload :ActiveRecord , 'rails3-jquery-autocomplete/orm/active_record'
		autoload :Mongoid      , 'rails3-jquery-autocomplete/orm/mongoid'
		autoload :MongoMapper  , 'rails3-jquery-autocomplete/orm/mongo_mapper'
  end
end

