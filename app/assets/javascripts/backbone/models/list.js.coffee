class TodoList.Models.List extends Backbone.Model
  paramRoot: 'list'

  defaults: {name: ''}

class TodoList.Collections.ListsCollection extends Backbone.Collection
  model: TodoList.Models.List
  url: '/lists'
