module Rails3JQueryAutocomplete
  module Test
    module Mongoid
      def setup
        ::Mongoid.configure do |config|
          name = "rails3_jquery_autocomplete_test"
          host = "localhost"
          config.master = Mongo::Connection.new.db(name)
          config.logger = nil
        end

        @movie_class = Object.const_set(:Movie, Class.new)
        @movie_class.send(:include, ::Mongoid::Document)
        @movie_class.field(:name, :class => String)
        @movie_class.class_eval do
          def display_name
            "Movie: #{name}"
          end
        end

        @controller = ActorsController.new

        @movie1  = @movie_class.create(:name => 'Alpha')
        @movie2 = @movie_class.create(:name => 'Alspha')
        @movie3 = @movie_class.create(:name => 'Alzpha')
      end

      def teardown
        Object.send(:remove_const, :Movie)          
        ::Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end
    end
  end
end
