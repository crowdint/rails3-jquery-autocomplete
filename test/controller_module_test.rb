require "test_helper"

class ActorsController < ApplicationController
  autocomplete :movie, :name
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

class Actor < ActiveRecord::Base
  belongs_to :movie
end

class Movie < ActiveRecord::Base
end

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :movies do |t|
      t.column :name, :string
    end

    create_table :actors do |t|
      t.column :movie_id, :integer
      t.column :name, :string
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class ActorsControllerTest < ActionController::TestCase
  def setup
    setup_db

    @controller          = ActorsController.new
    @controller.request  = @request  = ActionController::TestRequest.new
    @controller.response = @response = ActionController::TestResponse.new
  end

  def teardown
    teardown_db
  end

  def test_response_succesful
    get :autocomplete_movie_name, :term => 'Al'
    assert_response :success
  end

  def test_response_json
    @movie = Movie.create(:name => 'Alpha')

    get :autocomplete_movie_name, :term => 'Al'
    json_response = JSON.parse(@response.body)
    assert_equal(json_response.first["label"], @movie.name)
    assert_equal(json_response.first["value"], @movie.name)
    assert_equal(json_response.first["id"], @movie.id)
  end

  def test_alphabetic_order
    @movie = Movie.create(:name => 'Alzpha')
    @movie = Movie.create(:name => 'Alspha')
    @movie = Movie.create(:name => 'Alpha')

    get :autocomplete_movie_name, :term => 'Al'
    json_response = JSON.parse(@response.body)
    assert_equal(json_response.first["label"], "Alpha")
    assert_equal(json_response.last["label"], "Alzpha")
  end

  def test_response_limit
    @movie = Movie.create(:name => 'Alzpha')
    @movie = Movie.create(:name => 'Alspha')
    @movie = Movie.create(:name => 'Alpha')
    
    ActorsController.send(:autocomplete, :movie, :name, {:limit => 1})

    get :autocomplete_movie_name, :term => 'Al'
    json_response = JSON.parse(@response.body)
    assert_equal(json_response.length, 1)
  end
end