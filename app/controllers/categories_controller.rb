class CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
