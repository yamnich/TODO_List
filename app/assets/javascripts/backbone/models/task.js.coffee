class TodoList.Models.Task extends Backbone.Model
  paramRoot: 'task'

  defaults:  {name: "" , list_id: null, user_id: null, executor_id: null}

class TodoList.Collections.TasksCollection extends Backbone.Collection
  model: TodoList.Models.Task
  url: "/tasks"
