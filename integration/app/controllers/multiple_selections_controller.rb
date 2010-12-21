class MultipleSelectionsController < ApplicationController
  autocomplete :brand, :name

  def new
    @product = Product.new
  end
end
