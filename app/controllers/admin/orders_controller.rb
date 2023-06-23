class Admin::OrdersController < ApplicationController
  def customer_index
    @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
    @customer = Customer.find(params[:customer_id])
  end
  
  def show
  end
  
  def update
  end
  
end
