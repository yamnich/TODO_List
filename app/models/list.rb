
# == Schema Information
#
# Table name: lists
#     <h1>Lists#invite</h1>
#<p>Find me in app/views/lists/invite.html.erb</p>
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class List < ActiveRecord::Base
 # attr_accessor :user_id, :project_id

  has_many :tasks, dependent:  :destroy
  belongs_to :user
  belongs_to :project
  
  validates :name, presence: true 

end

