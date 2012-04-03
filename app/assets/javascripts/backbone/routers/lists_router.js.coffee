class TodoList.Routers.ListsRouter extends Backbone.Router
  initialize: (options) ->
    @lists = new TodoList.Collections.ListsCollection()
    @lists.reset options.lists



  routes:
    "/new"      : "newList"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"
    "/"        : "index"

  newList: ->
    @view = new TodoList.Views.Lists.NewView(collection: @lists)
    $("#lists").html(@view.render().el)

  index: ->
    @view = new TodoList.Views.Lists.IndexView(lists: @lists)
    $("#lists").html(@view.render().el)

  show: (id) ->
    list = @lists.get(id)

    @view = new TodoList.Views.Lists.ShowView(model: list)
    $("#lists").html(@view.render().el)

  edit: (id) ->
    list = @lists.get(id)

    @view = new TodoList.Views.Lists.EditView(model: list)
    $("#lists").html(@view.render().el)
