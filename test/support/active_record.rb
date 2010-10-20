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

        @movie  = Movie.create(:name => 'Alpha')
        @movie2 = Movie.create(:name => 'Alspha')
        @movie3 = Movie.create(:name => 'Alzpha')
      end

      def teardown
        ::ActiveRecord::Base.connection.tables.each do |table|
          ::ActiveRecord::Base.connection.drop_table(table)
        end
      end
    end
  end
end
