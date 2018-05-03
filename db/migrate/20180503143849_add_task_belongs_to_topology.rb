class AddTaskBelongsToTopology < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :topology, foreign_key: true, null: true
  end
end
