class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    @cart = find_cart
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
#    redirect_to_index
    respond_to do |format|
      format.js
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("tried to access invalid the product[#{params[:id]}].")
    redirect_to_index('invalid the product.');
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index('the cart is empty at the moment.');
  end
  
private
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end
    

  def find_cart
    session[:cart] ||= Cart.new
  end
end
