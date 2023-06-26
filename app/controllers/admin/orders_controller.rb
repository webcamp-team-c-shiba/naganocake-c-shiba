class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def customer_index
    @orders = Order.where(customer_id: params[:customer_id]).order(created_at: :desc).page params[:page]
    @customer = Customer.find(params[:customer_id])
  end

  def show
   @selected_order = Order.find(params[:id])
   @customer = @selected_order.customer

  end

  def update
    # enum status: { 着手不可:0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_items = @order.order_items
    if @order.status == Order.statuses.key(1)
      @order_items.each do |order_item|
        order_item.status = 1
        order_item.save
        # 複数メッセージ表示のための配列準備
        flash[:success] = []
        flash[:success] << "製作ステータスを変更しました。"
      end
    end
    # 複数メッセージ表示のための場合分け
    if flash[:success].nil?
      flash[:success] = "注文ステータスを変更しました。"
    else
      flash[:success] << "注文ステータスを変更しました。"
    end
    redirect_to admin_order_path
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

end
