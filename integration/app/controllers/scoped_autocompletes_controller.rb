class ScopedAutocompletesController < ApplicationController
  autocomplete :brand, :name, :scopes => ["active", "with_address"]

  def new
    @product = Product.new
  end
end
