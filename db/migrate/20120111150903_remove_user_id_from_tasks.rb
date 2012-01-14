class RemoveUserIdFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :user_id
  end

  def down
    add_column :tasks, :user_id, :integer
  end
end
