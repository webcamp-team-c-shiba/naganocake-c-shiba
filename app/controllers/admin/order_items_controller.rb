class Admin::OrderItemsController < ApplicationController

 before_action :authenticate_admin!

 def update
  @order_item = OrderItem.find(params[:id])
  order = Order.find(@order_item.order_id)

    if @order_item.update(order_item_params)
      if @order_item.status == OrderItem.statuses.key(2)
        order.status = Order.statuses.key(2)
        flash[:success] = []
        flash[:success] << "注文ステータスを変更しました。"
        order.save
      elsif @order_item.status == OrderItem.statuses.key(3)
        if OrderItem.where(order_id: order.id).count == OrderItem.where(order_id: order.id, status: 3 ).count
           order.status = Order.statuses.key(3)
           flash[:success] = []
           flash[:success] << "注文ステータスを変更しました。"
           order.save
        end
      end
    if flash[:success].nil?
      flash[:success] = "製作ステータスを変更しました。"
    else
      flash[:success] << "製作ステータスを変更しました。"
    end
    redirect_to admin_order_path(order)
    else
      redirect_back(fallback_location: root_path)
    end
 end

 private
 def order_item_params
  params.require(:order_item).permit(:status)
 end

end

