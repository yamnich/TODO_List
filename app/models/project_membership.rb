class ProjectMembership < ActiveRecord::Base

  belongs_to :project #, foreign_key: 'project_id'
  belongs_to :member, class_name: 'User'

  #attr_accessible :member_id, :project_id
end
