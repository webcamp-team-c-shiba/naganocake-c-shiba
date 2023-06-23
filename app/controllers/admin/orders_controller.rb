class Admin::OrdersController < ApplicationController
  def customer_index
    @orders = Order.where(customer_id: params[:customer_id]).order(created_at: :desc).page params[:page]
    @customer = Customer.find(params[:customer_id])
  end
  
  def show
   @selected_order = Order.find(params[:id])
   @customer = @selected_order.customer
   
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_items = @order.order_items
    
    if @order.status == "入金確認"
      @order_items.each do |order_items|
        order_items.status = "製作待ち"
        order_items.save
      end
    end
    redirect_to admin_order_path
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
  
end
