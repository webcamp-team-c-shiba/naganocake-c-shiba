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
    byebug
    @order = Order.new(order_params, customer_id: current_user.id, shipping_fee: @shipping_fee)
    if @orer.save
        @order_items.each do |order_item|
          @order_item = OrderItem.new(item_id: order_item.item_id, order_id: @order.id, price: order_item.item.price, amount: order_item.amount)
          @order_item.save
        end
        redirect_to orders_complete_path
    else
      render :check
    end
    
  end

  def index
    
  end

  def show
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment, :payment_method, :postcode, :address, :name)
  end
end
