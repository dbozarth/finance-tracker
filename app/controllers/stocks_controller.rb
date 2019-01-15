require 'rubygems'
require 'stock_quote'
class StocksController < ApplicationController 
  
  def search 
    if params[:stock].blank? 
      flash.now[:danger] = "You have entered an empty search string"
      render partial: 'users/result' 
    else 
      @stock_sym = Stock.new_from_lookup(params[:stock])
      if @stock_sym 
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end 
      else
        flash.now[:danger] = "You have entered an incorrect symbol"
        render partial: 'users/result'
      end 
    end 
    
  end 
end