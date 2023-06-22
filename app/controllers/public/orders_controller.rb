class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def check
    # 仮
    @order = Order.new(address: "東京", postcode: "0000000", name: "令和道子", payment_method: 1)
    #仮
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_fee = 800
  end

  def complete
    
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id 
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @order.save
        @cart_items.each do |cart_item|
          @order_item = OrderItem.new(item_id: cart_item.item_id, order_id: @order.id, price: cart_item.item.price, amount: cart_item.amount)
          @order_item.save
        end
        CartItem.where(customer_id: current_customer.id).destroy_all
        redirect_to orders_complete_path
    else
      render :check
    end
    
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private

  # def order_params
  #   params.require(:order).permit(:payment_method)
  # end

  def order_params
    params.require(:order).permit(:shipping_fee, :payment, :payment_method, :postcode, :address, :name)
  end
end
