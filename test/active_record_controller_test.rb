require "test_helper"

class Actor < ActiveRecord::Base
  belongs_to :movie
end

class Movie < ActiveRecord::Base
  def display_name
    "Movie: #{name}"
  end
end

class ActorsController < ActionController::Base
  autocomplete :movie, :name                       
end        

module Rails3JQueryAutocomplete
  module ActiveRecord
    module Test
      def setup
        ::ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        ::ActiveRecord::Schema.define(:version => 1) do
          create_table :movies do |t|
            t.column :name, :string
          end

          create_table :actors do |t|
            t.column :movie_id, :integer
            t.column :name, :string
          end
        end
      end

      def teardown
        ::ActiveRecord::Base.connection.tables.each do |table|
          ::ActiveRecord::Base.connection.drop_table(table)
        end
      end
    end
  end
end

class ActorsControllerTest < ActionController::TestCase

  include Rails3JQueryAutocomplete::ActiveRecord::Test

  context "the autocomplete gem" do
    setup do
      @movie  = Movie.create(:name => 'Alpha')
      @movie2 = Movie.create(:name => 'Alspha')
      @movie3 = Movie.create(:name => 'Alzpha')
    end

    should "be able to access the autocomplete action regardless of the quality of param[:term]" do
      get :autocomplete_movie_name
      assert_response :success

      get :autocomplete_movie_name, :term => ''
      assert_response :success

      get :autocomplete_movie_name, :term => nil
      assert_response :success

      get :autocomplete_movie_name, :term => 'Al'
      assert_response :success
    end

    should "respond with expected json" do
      get :autocomplete_movie_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], @movie.name)
      assert_equal(json_response.first["value"], @movie.name)
      assert_equal(json_response.first["id"], @movie.id)
    end

    should "return results in alphabetical order by default" do
      get :autocomplete_movie_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], "Alpha")
      assert_equal(json_response.last["label"], "Alzpha")
    end

    should "be able to sort in other ways if desired" do
      ActorsController.send(:autocomplete, :movie, :name, {:order => "name DESC"})

      get :autocomplete_movie_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.first["label"], "Alzpha")
      assert_equal(json_response.last["label"], "Alpha")
    end

    should "be able to limit the results" do
      ActorsController.send(:autocomplete, :movie, :name, {:limit => 1})

      get :autocomplete_movie_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, 1)
    end

    should "ignore case of search term and results" do
      @movie = Movie.create(:name => 'aLpHa')

      ActorsController.send(:autocomplete, :movie, :name)

      get :autocomplete_movie_name, :term => 'Al'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, Movie.count)
      assert_equal(json_response.last["label"], 'aLpHa')
    end

    should "match term to letters in middle of words when full-text search is on" do
      ActorsController.send(:autocomplete, :movie, :name, {:full => true})

      get :autocomplete_movie_name, :term => 'ph'
      json_response = JSON.parse(@response.body)
      assert_equal(json_response.length, Movie.count)
      assert_equal(json_response.first["label"], @movie.name)
    end

    should "be able to customize what is displayed" do
      ActorsController.send(:autocomplete, :movie, :name, {:display_value => :display_name})

      get :autocomplete_movie_name, :term => 'Al'

      json_response = JSON.parse(@response.body)

      assert_equal(@movie.display_name, json_response.first["label"])
      assert_equal(@movie.display_name, json_response.first["value"])
      assert_equal(@movie.id, json_response.first["id"])
    end
  end
end
