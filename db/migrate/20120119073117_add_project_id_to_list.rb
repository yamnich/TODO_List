class AddProjectIdToList < ActiveRecord::Migration
  def change
    add_column :lists, :project_id, :integer
  end
end
