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
    if @order.status == Order.statuses.key(1)
      @order_items.each do |order_item|
        order_item.status = 1
        order_item.save
      end
    end
    flash[:success] = "製作ステータスを変更しました。"
    redirect_to admin_order_path
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

end
