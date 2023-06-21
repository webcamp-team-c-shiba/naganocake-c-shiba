class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!
    
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:info] = "商品が登録されました。"
      redirect_to admin_item_path(@item)
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
      flash[:success] = "商品情報が更新されました。"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :description, :price, :is_stopped)
  end
end
