class NodesController < ApplicationController
  before_action :set_nodes_by_topology, only: [:index, :count, :create]
  before_action :set_node_by_topology, only: [:show, :update, :destroy, :show_links]

  def index
   render json: @nodes
  end

  def show
    render :json => @node
  end

  def create
    @node = @nodes.create params.require(:node).permit(:name)
    render json: @node
  end

  def update
    @node = @node.update params.require(:node).permit(:name)
    render json: @node
  end

  def count
    render :json => @nodes.count
  end

  def show_links
    render :json => @node.links.to_json(include: [:source_node, :target_node])
  end

  def destroy
    @node.delete
    render :json => {}
  end

  private

  def set_nodes_by_topology
    begin
      topology = Topology.find(params[:topology_id])
      @nodes = topology.nodes
    rescue
      @nodes = []
    end
  end

  def set_node_by_topology
    begin
      set_nodes_by_topology
      @node = @nodes.find(params[:id])
    rescue
      @node = {}
    end
  end

end
