class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def check
    customer = current_customer
    session[:order] = Order.new
    session[:order][:payment_method] = params[:method].to_i
    
    @order = Order.new(order_params)
    @order.postcode = current_customer.postcode
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
 

    destination = params[:a_method].to_i
    
   
		if destination == 0

			session[:order][:postcode] = customer.postcode
			session[:order][:address] = customer.address
			session[:order][:name] = customer.last_name + customer.first_name

		
		elsif destination == 1

			address = address.find(params[:address])
			session[:order][:postcode] = address.postcode
			session[:order][:address] = address.address
			session[:order][:name] = address.name 

		
		elsif destination == 2

			session[:new_address] = 2
			session[:order][:postcode] = params[:postcode]
			session[:order][:address] = params[:address]
			session[:order][:name] = params[:name]

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
