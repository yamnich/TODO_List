TodoList.Views.Tasks ||= {}

class TodoList.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  initialize: () ->
    @options.tasks.bind('reset', @addAll)

  addAll: () =>
    @options.tasks.each(@addOne)
    @$("#tasks_new").append('<a href = "/#/lists/'+@options.list.attributes.id+'/tasks/new" > New task</a>')

  addOne: (task) =>
    view = new TodoList.Views.Tasks.TaskView({model : task})
    @$("#tasks").append(view.render().el)

  render: =>
    $(@el).html(@template(tasks: @options.tasks.toJSON() ))
    @addAll()

    return this
