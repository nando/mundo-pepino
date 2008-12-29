class OrchardsController < ApplicationController
  def show
    @orchard = Orchard.find(params[:id])
  end

  def new
    @orchard = Orchard.new
  end

  def create
    @orchard = Orchard.new(params[:orchard])
    if @orchard.save
      flash[:notice] = 'Huerto creado con éxito.'
      redirect_to(@orchard)
    else
      render :action => "new"
    end
  end
end
