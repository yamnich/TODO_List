class TodoList.Routers.ProjectsRouter extends Backbone.Router
  initialize: (options) ->
    @projects = new TodoList.Collections.ProjectsCollection()
    @projects.reset options.projects

    @projects_invited_in = new TodoList.Collections.ProjectsCollection()
    @projects_invited_in.reset options.projects_invited_in

    @lists = new TodoList.Collections.ListsCollection()
    @lists.reset options.lists

    @project_lists = new TodoList.Collections.ListsCollection()

  routes:
    "/new"         : "newProject"
    "/index"       : "index"
    "/:id/edit"    : "edit"
    "/:id/lists"   : "show"
    "/"            : "index"
    ".*"           : "index"
    "/:id/lists/new"   : "newList"

  newProject: ->
    @view = new TodoList.Views.Projects.NewView(collection: @projects)
    $("#projects").html(@view.render().el)

  index: ->
    @view = new TodoList.Views.Projects.IndexView(projects: @projects, projects_invited_in: @projects_invited_in)
    $("#projects").html(@view.render().el)

  show: (id) ->
    if  !@projects.get(id)
      project = @projects_invited_in.get(id)
    else
      project = @projects.get(id)

    @project_lists.reset project.get('lists')
    @view = new TodoList.Views.Lists.IndexView(lists: @project_lists, project: project)
    $("#projects").html(@view.render().el)


  edit: (id) ->
    project = @projects.get(id)

    @view = new TodoList.Views.Projects.EditView(model: project)
    $("#projects").html(@view.render().el)

  newList: ->
    @view = new TodoList.Views.Lists.NewView(collection: @project_lists)
    $("#projects").html(@view.render().el)
