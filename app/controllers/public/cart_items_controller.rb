class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total_price = 0
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:success] = "商品の数量を変更しました。"
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:danger] = "カート内の商品を削除しました。"
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy_all
    flash[:danger] = "カート内の全ての商品を削除しました。"
    redirect_to cart_items_path
  end
  
  def create
    if @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.customer_id = current_customer.id
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      flash[:warning] = "商品の数量を変更しました。"
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.amount.to_i > 0 && @cart_item.save
        @cart_item.save
        flash[:info] = "商品をカートに追加しました。"
      else
        @cart_item.save
        flash[:warning] = "個数選択をしてください"
        redirect_to item_path(params[:cart_item][:item_id])
        return
      end
    end
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
