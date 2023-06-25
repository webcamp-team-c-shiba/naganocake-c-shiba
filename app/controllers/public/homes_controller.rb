class Public::HomesController < ApplicationController

  def top
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def about
  end
end
