class Task < ActiveRecord::Base
  belongs_to :list
  belongs_to :executor, class_name: 'User'
  belongs_to :user
  validates :name, presence: true

  before_create do
   list = List.find_by_id(self.list_id)
   self.executor_id ||= list.user_id
  end

  state_machine :state, initial: :in_work  do
     state :in_work
     state :done

    event :change_state do
      transition in_work: :done,  do: :send_email_to
      transition done: :in_work, do: :send_email_to
    end
  end

  def send_email_to(user)
    if self.executor_id != user.id
      user = User.find_by_id(self.executor_id)
      UserMailer.assignment(user, self).deliver
    end
  end

end


