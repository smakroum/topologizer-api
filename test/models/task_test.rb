require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "find task" do
    assert_equal "Task1", tasks(:one).name
    assert_equal "Task2", tasks(:two).name
  end
end
