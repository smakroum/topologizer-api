class LinksController < ApplicationController
  before_action :set_links_by_topology, only: [:index, :count, :create]
  before_action :set_link_by_topology, only: [:show, :update, :destroy]

  def index
    render json: @links
  end

  def show
    render :json => @link
  end

  def create
    @link = @links.create params.require(:link).permit(:source_id, :target_id)
    render json: @link
  end

  def update
    @link = @link.update params.require(:link).permit(:source_id, :target_id)
    render json: @link
  end

  def count
    render :json => @links.count
  end

  def destroy
    @link.delete
    render :json => {}
  end

  private

  def set_links_by_topology
    begin
      topology = Topology.find(params[:topology_id])
      @links = topology.links
    rescue
      @links = []
    end
  end

  def set_link_by_topology
    begin
      set_links_by_topology
      @link = @links.find(params[:id])
    rescue
      @link = {}
    end
  end
end
