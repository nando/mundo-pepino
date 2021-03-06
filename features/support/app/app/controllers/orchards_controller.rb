class OrchardsController < ApplicationController
  def index
    @orchards = Orchard.find(:all, :order => :id)
  end      

  def show
    @orchard = Orchard.find(params[:id][/^(\d+)-.*$/, 1])
  end

  def edit
    @orchard = Orchard.find(params[:id][/^(\d+)-.*$/, 1])
  end

  def new
    @orchard = Orchard.new
  end

  def create
    @orchard = Orchard.new(params[:orchard])
    if @orchard.save
      flash[:notice] = 'The orchard was successfully created.'
      redirect_to @orchard
    else
      render :action => "new"
    end
  end

  def update
    @orchard = Orchard.find(params[:id])
    if @orchard.update_attributes(params[:orchard])
      flash[:notice] = 'Orchard was successfully updated.'
      redirect_to @orchard
    else
      render :action => "edit"
    end
  end

  def destroy
    @orchard = Orchard.find(params[:id])
    @orchard.destroy
    redirect_to(orchards_url) 
  end
end
