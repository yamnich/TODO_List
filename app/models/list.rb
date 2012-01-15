
# == Schema Information
#
# Table name: lists
#     <h1>Lists#new</h1>
#<p>Find me in app/views/lists/new.html.erb</p>
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class List < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :tasks, :dependent => :destroy
  belongs_to :user
  validates :name, :presence => true, :uniqueness => true


end

