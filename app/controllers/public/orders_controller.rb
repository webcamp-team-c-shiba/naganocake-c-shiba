class Public::OrdersController < ApplicationController
  
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
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
