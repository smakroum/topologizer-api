require 'test_helper'

class NodesControllerTest < ActionDispatch::IntegrationTest
  test "GET topologies/1/nodes. Should return two nodes as json" do
    get topology_nodes_path(topologies(:topology_one))
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.headers["Content-Type"]
    assert_equal 2, @response.parsed_body.count
    assert_equal "NodeTest1", @response.parsed_body[0]["name"]
    assert_equal "NodeTest2", @response.parsed_body[1]["name"]
  end

  test "GET topologies/2/nodes. Should return one node as json" do
    get topology_nodes_path(topologies(:topology_two))
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.headers["Content-Type"]
    assert_equal 1, @response.parsed_body.count
    assert_equal "NodeTest3", @response.parsed_body[0]["name"]
  end

  test "GET topologies/1/nodes/1. Should return node 1 as json" do
    @topology = topologies(:topology_one)
    get topology_node_path(@topology, 1)
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.headers["Content-Type"]
    assert_equal 1, response.parsed_body["id"]
    assert_equal "NodeTest1", response.parsed_body["name"]
  end

  test "POST topologies/1/nodes. Should save one Node as json" do
    topology = topologies(:topology_one)
    assert_equal "Topology1", topology.name
    post topology_nodes_path(topology), as: :json, params: {
        name: "NodeTest4",
    }
    assert_response :success
    node =  Node.find_by(name: "NodeTest4")
    assert_not_nil node
    assert_equal topology, node.topology
  end

  test "PUT topology/1. Should update topology as json" do
    topology = topologies(:topology_one)
    assert_equal "Topology1", topology.name
    node_id = 1
    put topology_node_path(topology, node_id), as: :json, params: {
        name: "NodeTest1updated",
    }
    assert_response :success
    node_after_update = Node.find(node_id)
    assert_equal "NodeTest1updated", node_after_update.name
  end

  test "DELETE topology/1/nodes/1. Should delete node 1 as json" do
    topology = topologies(:topology_one)
    node_id = 1
    delete topology_node_path(topology, node_id)
    assert_response :success
    assert_nil Node.find_by(id: node_id)
  end


end
