class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    if CartItem.where(customer_id: current_customer.id).count == 0 
      flash[:danger] = "カート内に商品がありません"
      redirect_to items_path
    else
      @order = Order.new
      @customer = Customer.find(current_customer.id)
    end
  end

  def check
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      
    elsif params[:order][:address_option] == "1"
      @addresses = Address.all
      @selected_address = Address.find(params[:order][:address_id])
      @order.postcode = @selected_address.postcode
      @order.address = @selected_address.address
      @order.name = @selected_address.name 
      
    elsif params[:order][:address_option] = "2"
      @order.postcode = params[:order][:postcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
    
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
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
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
