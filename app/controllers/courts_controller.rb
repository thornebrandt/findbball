class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
  end
  
  def new
  end
  
end
