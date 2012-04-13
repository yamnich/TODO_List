TodoList.Views.Tasks ||= {}

class TodoList.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  initialize: () ->
    @options.tasks.bind('reset', @addAll)

  addAll: () =>
    @options.tasks.each(@addOne)
    @$("#tasks_new").append('<a href = "/#/lists/'+@options.list.attributes.id+'/tasks/new"  > New task</a>')
    @$("#done_tasks").append('<a href = "/#/lists/'+@options.list.attributes.id+'/tasks/done" > Done</a>')
    @$("#in_work_tasks").append('<a href = "/#/lists/'+@options.list.attributes.id+'/tasks/inwork" > In work</a>')
    @$("#all_tasks").append('<a href = "/#/lists/'+@options.list.attributes.id+'/tasks" > Show all</a>')

  addOne: (task) =>
    view = new TodoList.Views.Tasks.TaskView({model : task})
    @$("#tasks").append(view.render().el)

  render: =>
    $(@el).html(@template(tasks: @options.tasks.toJSON() ))
    @addAll()

    return this
