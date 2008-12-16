class OrchardsController < ApplicationController
  def show
    @orchard = Orchard.find(params[:id])
  end
end
