module Rails3JQueryAutocomplete
  module Autocomplete
    def self.included(target)
      target.extend Rails3JQueryAutocomplete::Autocomplete::ClassMethods

      if defined?(Mongoid::Document)
        target.send :include, Rails3JQueryAutocomplete::Orm::Mongoid
      elsif defined?(MongoMapper::Document)
        target.send :include, Rails3JQueryAutocomplete::Orm::MongoMapper
      else
        target.send :include, Rails3JQueryAutocomplete::Orm::ActiveRecord
      end
    end

    module ClassMethods
      def autocomplete(object, method, options = {})
        self.send :include, Rails3JQueryAutocomplete::Orm::ActiveRecord
        self.send :include, Rails3JQueryAutocomplete::Controller

        define_method "source_model" do
          sym_to_class(object)
        end

        define_method "source_method" do
          method
        end
      end
    end
  end
end

