require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "GET tasks. Should return two tasks as json" do
    get tasks_path
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.headers["Content-Type"]
    assert_equal 2, response.parsed_body.count
    assert_equal "Task1", response.parsed_body[0]["name"]
    assert_equal tasks(:task_one).start, response.parsed_body[0]["start"]
    assert_equal tasks(:task_one).end, response.parsed_body[0]["end"]
    assert_equal "Task2", response.parsed_body[1]["name"]
    assert_equal tasks(:task_two).start, response.parsed_body[1]["start"]
    assert_equal tasks(:task_two).end, response.parsed_body[1]["end"]
  end

  test "GET task/1. Should return task 1 as json" do
    @topology = tasks(:task_one)
    get task_path(@topology)
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.headers["Content-Type"]
    assert_equal 1, response.parsed_body["id"]
    assert_equal "Task1", response.parsed_body["name"]
    assert_equal @topology.start, response.parsed_body["start"]
    assert_equal @topology.end, response.parsed_body["end"]
  end

  test "POST tasks. Should save one task as json" do
    post tasks_path, as: :json, params: {
        name: "Task3",
        start: DateTime.now,
        end: DateTime.now + 4.hour
    }
    assert_response :success
    assert_not_nil Task.find_by(name: "Task3")
  end

  test "PUT task/1. Should update task as json" do
    task = tasks(:task_one)
    assert_equal "Task1", task.name
    put task_path(task), as: :json, params: {
        name: "Task1updated",
    }
    assert_response :success
    task_after_update = Task.find(task.id)
    assert_equal "Task1updated", task_after_update.name
  end

  test "DELETE task/1/. Should delete task 1" do
    task = tasks(:task_one)
    delete task_path(task)
    assert_response :success
    assert_nil Task.find_by(id: task.id)
  end

end
