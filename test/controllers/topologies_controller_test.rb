require 'test_helper'

class TopologiesControllerTest < ActionDispatch::IntegrationTest
  test "GET topologies. Should return two tasks as json" do
    get topologies_path
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.headers["Content-Type"]
    assert_equal 2, @response.parsed_body.count
    assert_equal "Topology1", @response.parsed_body[0]["name"]
    assert_equal "Topology2", @response.parsed_body[1]["name"]
  end

  test "GET topology/1. Should return topology 1 as json" do
    @topology = topologies(:topology_one)
    get url_for(@topology)
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.headers["Content-Type"]
    assert_equal 1, response.parsed_body["id"]
    assert_equal "Topology1", response.parsed_body["name"]
  end

  test "POST topologies. Should save one topology as json" do
    post topologies_path, as: :json, params: {
        name: "Topology3",
    }
    assert_response :success
    assert_not_nil Topology.find_by(name: "Topology3")
  end

  test "PUT topology/1. Should update topology as json" do
    @topology = topologies(:topology_one)
    assert_equal "Topology1", @topology.name
    put url_for(@topology), as: :json, params: {
        name: "Topology1updated",
    }
    assert_response :success
    @topology_after_update = Topology.find(@topology.id)
    assert_equal "Topology1updated", @topology_after_update.name
  end
end
