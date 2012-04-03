TodoList.Views.Lists ||= {}

class TodoList.Views.Lists.IndexView extends Backbone.View
  template: JST["backbone/templates/lists/index"]

  initialize: () ->
    @options.lists.bind('reset', @addAll)

  addAll: () =>
    @options.lists.each(@addOne)
    if @options.project
      @$("#lists_new").append('<a href = "/#/projects/'+@options.project.attributes.id+'/lists/new" > New list</a>')
    else
      @$("#lists_new").append('<a href = "/#/lists/new" > New list</a>')
  addOne: (list) =>
    view = new TodoList.Views.Lists.ListView({model : list})
    @$("#lists").append(view.render().el)
    if @options.project
      @$("#li_edit").append('<a href = "/#/projects/'+@options.project.attributes.id+'/lists/" > Edit list</a>')
      @$("#li_destroy").append('<a href = "/#/projects/'+@options.project.attributes.id+'/lists/new" > New list</a>')
    else
      @$("#li_edit").append('<a href = "/#/lists/new" > New list</a>')
      @$("#li_destroy").append('<a href = "/#/lists/new" > New list</a>')


  render: =>
    $(@el).html(@template(lists: @options.lists.toJSON() ))
    @addAll()

    return this
