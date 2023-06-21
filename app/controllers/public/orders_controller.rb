class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def check
    # 仮--
    @order = Order.new
    @order.payment_method = 1
    @order.address = "〒0000000 東京都　令和道子"
    # 仮--
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_fee = 800
  end

  def complete
    
  end

  def create
    @customer = current_customer
    session[:order] = Order.new
  end

  def index
    
  end

  def show
    
  end
end
