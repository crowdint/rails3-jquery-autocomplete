class NestedModelsController < ApplicationController
  autocomplete :feature, :name

  def new
    @product = Product.new
    @feature = @product.features.build(:name => 'Glowy,')
  end
end
