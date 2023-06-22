class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:info] = "ジャンルが作成されました。"
      redirect_to admin_genres_path
    els
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = "ジャンルが更新されました。"
      redirect_to admin_genres_path
    else
      @genre = Genre.find(params[:id])
      render :edit
    end
  end
  
  
  private

  def genre_params
    params.require(:genre).permit(:name) # ジャンル名のパラメータを指定
  end
  
end
