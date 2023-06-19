class Public::OrdersController < ApplicationController
  def new
    
  end

  def check
    
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
