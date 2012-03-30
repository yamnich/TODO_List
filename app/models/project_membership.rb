class ProjectMembership < ActiveRecord::Base

  belongs_to :project
  belongs_to :member, class_name: 'User'

  validates_uniqueness_of :member_id, scope: :project_id



end
