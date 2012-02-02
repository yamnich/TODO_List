class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.integer :member_id
      t.integer :project_id

      t.timestamps
    end
  end
end
