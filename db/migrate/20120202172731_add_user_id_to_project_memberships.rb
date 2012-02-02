class AddUserIdToProjectMemberships < ActiveRecord::Migration
  def change
    add_column :project_memberships, :user_id, :integer
  end
end
