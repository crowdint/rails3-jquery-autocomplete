class SubClassesController < ApplicationController
  autocomplete :foreign_brand, :name

  def new
    @product = Product.new
  end
end
