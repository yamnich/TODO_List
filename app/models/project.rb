class Project < ActiveRecord::Base
  attr_accessible :name, :description, :user_id
  belongs_to  :user;
  has_many :lists, dependent:  :destroy
  has_many :project_memberships
  has_many  :members, through: :project_memberships

  validates :name, presence: true
end
