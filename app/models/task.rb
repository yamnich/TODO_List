class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :executor, class_name: 'User'
  validates :name, presence: true

  before_create do
    list = List.find_by_id(self.list_id)
    self.executor_id ||= list.user_id
  end

end


