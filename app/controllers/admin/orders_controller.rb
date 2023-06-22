class Admin::OrdersController < ApplicationController
  def index
  end

  def show
    @customer = Customer.find(current_customer.id)
    @orders = Order.all
    @selected_order = Order.find(params[:id])
  end
  
  def update
  end

  private
  
  def order_params
    params.require(:order).permit(:shipping_fee, :payment, :payment_method, :postcode, :address, :name)
  end
  
end
