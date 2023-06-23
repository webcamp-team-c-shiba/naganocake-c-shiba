class Public::ItemsController < ApplicationController

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_stopped: false).page(params[:page]).per(12)
    else
      @items = Item.where(is_stopped: false).page(params[:page]).per(12)
    end
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
  
  
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :price)
  end
end
