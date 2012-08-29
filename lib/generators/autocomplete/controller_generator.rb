require 'rails/generators'

module Autocomplete
  class ControllerGenerator < Rails::Generators::Base
    argument :source_object, :type => :string
    argument :source_method, :type => :string

    def install
      destination = "app/controllers/autocomplete/#{camelized_arguments.underscore}_controller.rb"

      template 'controller.rb.erb', "#{destination}",
      		:controller_class_name => camelized_arguments,
      		:source_method => source_method.underscore,
    			:source_object => source_object.underscore

    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    private
    def camelized_arguments
      "#{source_object}_#{source_method}".camelize
    end
  end
end
