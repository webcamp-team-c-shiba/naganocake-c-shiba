class Public::ItemsController < ApplicationController

  def index
    @total_items = Item.all
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genle_id, :name, :image, :price)
  end
end
