module Rails3JQueryAutocomplete
  module TestCase
    module MongoMapper
      def setup
        ::MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
        ::MongoMapper.database = "rails3_jquery_autocomplete_test"
        
        create_models

        @controller = ActorsController.new
        @movie1 = @movie_class.create(:name => 'Alpha')
        @movie2 = @movie_class.create(:name => 'Alspha')
        @movie3 = @movie_class.create(:name => 'Alzpha')
      end

      def teardown
        destroy_models
        ::MongoMapper.database.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      end

      private
      def create_models
        @movie_class = Object.const_set(:Movie, Class.new)
        @movie_class.send(:include, ::MongoMapper::Document)
        @movie_class.key(:name, :class => String)
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