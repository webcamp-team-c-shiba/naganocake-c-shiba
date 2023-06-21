class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      
    elsif params[:order][:address_option] == "1"
      @addresses = Address.all
      @selected_address = Address.find(params[:order][:customer_id])
      @address_id = @selected_address.id
      @order.postcode = postcode
      @order.address = address
      @order.name = name 
      
    elsif params[:order][:address_option] = "2"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      
    else
      render 'new'
    end

    cart_items = current_customer.cart_items
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_fee = 800
  end

  def complete
    
  end

  def create
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
    params.require(:order).permit(:payment_method, :payment, :postcode, :address, :name)
  end
end
