class Project < ActiveRecord::Base

  belongs_to  :user

  has_many :lists, dependent:  :destroy
  has_many :project_memberships
  has_many  :members, through: :project_memberships

  validates :name, presence: true

  def invite_user(member)
    UserMailer.invite(member,self.name).deliver
  end
end
