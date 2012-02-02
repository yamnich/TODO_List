class ProjectMembership < ActiveRecord::Base
  attr_accessible :member_id, :project_id

  belongs_to :project , foreign_key: 'project_id'
  belongs_to :member, class_name: 'User', foreign_key: 'member_id'
end
