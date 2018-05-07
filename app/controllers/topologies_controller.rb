class TopologiesController < ApplicationController
  def index
    @topologies = Topology.all
    render json: @topologies
  end

  def show
    @topology = Topology.find(params[:id])
    render :json => @topology
  end

  def create
    @topology = Topology.create params.require(:topology).permit(:name)
    render json: @topology
  end

  def update
    @topology = Topology.find(params[:id])
    @topology = @topology.update params.require(:topology).permit(:name)
    render json: @topology
  end

  def destroy
    @topology = Topology.find(params[:id])
    @topology.delete
  end

  def count
    @topologies = Topology.all
    render :json => @topologies.count
  end

end
