require "test_helper"
require 'test_controller'
require 'support/mongoid'
require 'support/mongo_mapper'
require 'support/active_record'

class ActiveRecordControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::TestCase::ActiveRecord
  include Rails3JQueryAutocomplete::TestCase
end

class ActiveRecordSTIControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::TestCase::ActiveRecord
  include Rails3JQueryAutocomplete::TestCase

  def create_models
    @parent_movie_class = Object.const_set(:Movie, Class.new(::ActiveRecord::Base))
    @parent_movie_class.class_eval do
      def display_name
        "Movie: #{name}"
      end
    end
    @movie_class = Object.const_set(:HorrorMovie, Class.new(@parent_movie_class))
  end

  def destroy_models
    Object.send(:remove_const, :Movie)
    Object.send(:remove_const, :HorrorMovie)
  end

end

class MonogidControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::TestCase::Mongoid
  include Rails3JQueryAutocomplete::TestCase
end

class MongoMapperControllerTest < ActionController::TestCase
  include Rails3JQueryAutocomplete::TestCase::MongoMapper
  include Rails3JQueryAutocomplete::TestCase
end
