require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "GET topologies/1/links. Should return two links as json" do
    get topology_links_path(topologies(:topology_one))
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.headers["Content-Type"]
    assert_equal 2, @response.parsed_body.count

    assert_equal 1, @response.parsed_body[0]["source_id"]
    assert_equal 2, @response.parsed_body[0]["target_id"]

    assert_equal 1, @response.parsed_body[1]["source_id"]
    assert_equal 3, @response.parsed_body[1]["target_id"]

  end

  test "GET topologies/2/links. Should return error links as json" do
    get topology_links_path(topologies(:topology_two))
    assert_response :success
    assert_equal "application/json; charset=utf-8", @response.headers["Content-Type"]
    assert_equal 1, @response.parsed_body.count
    assert_equal 2, @response.parsed_body[0]["source_id"]
    assert_equal 3, @response.parsed_body[0]["target_id"]
  end

  test "GET topologies/1/links/1. Should return link 1 as json" do
    @topology = topologies(:topology_one)
    get topology_link_path(@topology, 1)
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.headers["Content-Type"]
    assert_equal 1, response.parsed_body["id"]
    assert_equal 1, @response.parsed_body["source_id"]
    assert_equal 2, @response.parsed_body["target_id"]
  end

  test "POST topologies/1/links. Should save one Link as json" do
    topology = topologies(:topology_one)
    Node.create id: 4, name: "NodeTest4", topology_id: topology.id
    post topology_links_path(topology), as: :json, params: {
        source_id: 1,
        target_id: 4
    }
    assert_response :success
    link =  Link.find_by(source_id: 1, target_id: 4)
    assert_not_nil link
    assert_equal topology.id, link.topology_id
  end

  test "PUT topology/1/links/1. Should update link 1 as json" do
    topology = topologies(:topology_one)
    link_id = 1
    Node.create id: 4, name: "NodeTest4", topology_id: topology.id
    put topology_link_path(topology, link_id), as: :json, params: {
        target_id: 4
    }
    assert_response :success
    link_after_update = Link.find(link_id)
    assert_equal 4, link_after_update.target_id
  end

  test "DELETE topology/1/links/1. Should delete link 1 as json" do
    topology = topologies(:topology_one)
    link_id = 1
    delete topology_link_path(topology, link_id)
    assert_response :success
    assert_nil Link.find_by(id: link_id)
  end
end
