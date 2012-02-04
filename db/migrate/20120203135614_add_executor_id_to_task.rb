class AddExecutorIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :executor_id, :integer
  end
end
