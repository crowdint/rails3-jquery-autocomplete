module Rails3JQueryAutocomplete
  module TestCase
    module Mongoid
      def setup
        ::Mongoid.configure do |config|
          name = "rails3_jquery_autocomplete_test"
          host = "localhost"
          config.master = Mongo::Connection.new.db(name)
          config.logger = nil
        end

        create_models

        @controller = ActorsController.new
        @movie1 = @movie_class.create(:name => 'Alpha')
        @movie2 = @movie_class.create(:name => 'Alspha')
        @movie3 = @movie_class.create(:name => 'Alzpha')
      end

      def teardown
        destroy_models
        ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end

      private
      def create_models
        @movie_class = Object.const_set(:Movie, Class.new)
        @movie_class.send(:include, ::Mongoid::Document)
        @movie_class.field(:name, :class => String)
        @movie_class.class_eval do
          def display_name
            "Movie: #{name}"
          end
        end
      end

      def destroy_models
        Object.send(:remove_const, :Movie)
      end

    end
  end
end
