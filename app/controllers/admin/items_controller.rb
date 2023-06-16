class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: '商品が作成されました。'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path, notice: '商品が更新されました。'
    else
      render :edit
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :description, :price, :is_stopped)
  end
end
