require "test_helper"

class ActorsController < ApplicationController; end

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
    ActorsController.send(:autocomplete, :movie, :name)
    get :autocomplete_movie_name, :term => 'Al'
    assert_response :success
  end

  def test_response_json
    @movie = Movie.create(:name => 'Alpha')

    ActorsController.send(:autocomplete, :movie, :name)
    get :autocomplete_movie_name, :term => 'Al'
    json_response = JSON.parse(@response.body)
    assert_equal(json_response.first["label"], @movie.name)
    assert_equal(json_response.first["value"], @movie.name)
    assert_equal(json_response.first["id"], @movie.id)
  end
end