Factory.define :task do |task|
  task.name "Example task"
  task.description "Task description"
  task.state "Not done"
  task.priority 1
  task.executor_id 1
end