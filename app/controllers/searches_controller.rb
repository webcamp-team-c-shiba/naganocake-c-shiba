class SearchesController < ApplicationController
  
  def search
    @records = Item.looks(params[:word])
    @word = params[:word]
  end
  
end
