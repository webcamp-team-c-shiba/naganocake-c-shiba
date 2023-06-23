class Admin::OrdersController < ApplicationController
  def customer_index
    @orders = Order.where(customer_id: params[:customer_id]).order(created_at: :desc).page params[:page]
    @customer = Customer.find(params[:customer_id])
  end
  
  def show
  end
  
  def update
  end
  
end
