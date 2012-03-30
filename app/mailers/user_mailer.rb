class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite(user, project)
    mail(to: user.email, subject: "#{user.name}, you were invited to the project #{project}")
  end

  def assignment(user,  task)
    mail(to: user.email, subject: "You get invite to task #{task}")
  end

  def changed(user, project, task)
    mail(to: user.email, subject: "Your task '#{task}' state in '#{project}' project was changed")
  end

end
