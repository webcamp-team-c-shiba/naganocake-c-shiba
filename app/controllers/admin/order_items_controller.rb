class Admin::OrderItemsController < ApplicationController

 before_action :authenticate_admin!

 def update

  @order_item = OrderItem.find(params[:id])
  order = Order.find(@order_item.order_id)

    if @order_item.update(order_item_params)
      if @order_item.status == "製作中"
        order.status = "製作中"
        order.save
      elsif @order_item.status == "製作完了"
        if OrderItem.where(order_id: order.id).count == OrderItem.where(order_id: order.id, status: "製作完了" ).count
           order.status = "発送準備中"
           order.save
        end
      end
    flash[:success] = "製作ステータスを変更しました。"
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

