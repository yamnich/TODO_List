class Project < ActiveRecord::Base
 # attr_accessible :name, :description, :user_id
  belongs_to  :user;
  has_many :lists, dependent:  :destroy
  has_many :project_memberships, foreign_key: 'project_id'
  has_many  :members, through: :project_memberships#, :source => :users


  validates :name, presence: true#, uniqueness: {:case_sensitive => false}
end
