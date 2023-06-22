class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all.order(created_at: :desc) 
  end

  def show
  end
  
  def update
  end
  
end
