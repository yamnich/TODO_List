class Project < ActiveRecord::Base
 # attr_accessible :name, :description, :user_id
  has_many :lists, dependent:  :destroy
  validates :name, presence: true#, uniqueness: {:case_sensitive => false}
end
