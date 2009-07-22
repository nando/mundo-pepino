class FertilizersController < ApplicationController
  def index
    @fertilizers = Fertilizer.find(:all, :order => :id)
  end      
end
