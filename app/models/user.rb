class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :projects

  has_many :project_memberships, foreign_key: 'member_id'
  has_many :projects, through: :project_memberships

  has_many :lists,  dependent: :destroy

  has_many :tasks, foreign_key: 'executor_id'

  def member?(project)
    project_memberships.find_by_project_id(project)
  end

  def join!(project)
    project_memberships.create!(project_id: project.id)
  end

  def leave!(project)
    project_memberships.find_by_project_id(project).destroy
  end

  def own_projects
    Project.where("user_id = ?", self.id)
  end

  def projects_invited_in
    self.projects
  end

end
