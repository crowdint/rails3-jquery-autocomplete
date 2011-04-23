class ScopedAutocompletesControllerController < ApplicationController
  autocomplete :brand, :name, :scope => "active"

  def new
    @product = Product.new
  end
end
