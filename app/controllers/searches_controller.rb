class SearchesController < ApplicationController
  
  def search
    @records = Item.looks(params[:word]).where(is_stopped: false)
    @word = params[:word]
  end
  
end
