class StoreController < ApplicationController
	include Concerns::CurrentCart
	before_action :set_cart
  def index
  	@products=Product.order(:title)
  end
end
