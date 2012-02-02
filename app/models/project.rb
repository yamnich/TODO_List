class Project < ActiveRecord::Base
 # attr_accessible :name, :description, :user_id
  belongs_to  :user;
  #has_and_belongs_to_many  :users;
   has_many :lists, dependent:  :destroy

  validates :name, presence: true#, uniqueness: {:case_sensitive => false}
end
