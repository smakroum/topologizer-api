require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "find task" do
    assert_equal "Task1", tasks(:task_one).name
    assert_equal "Task2", tasks(:task_two).name
  end
end
