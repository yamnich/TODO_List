class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :executor, class_name: 'User'
  validates :name, presence: true
end


