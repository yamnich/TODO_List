class TodoList.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults: {name: ''}

class TodoList.Collections.UsersCollection extends Backbone.Collection
  model: TodoList.Models.User
  url: '/users'
