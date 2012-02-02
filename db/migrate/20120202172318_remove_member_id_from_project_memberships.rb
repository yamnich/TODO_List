class RemoveMemberIdFromProjectMemberships < ActiveRecord::Migration
  def up
    remove_column :project_memberships, :member_id
  end

  def down
    add_column :project_memberships, :member_id, :integer
  end

end
