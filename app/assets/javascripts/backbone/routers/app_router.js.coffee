class TodoList.Routers.AppRouter extends Backbone.Router

  initialize: (options) ->
    @projects = new TodoList.Collections.ProjectsCollection()
    @projects.reset options.projects

    @projects_invited_in = new TodoList.Collections.ProjectsCollection()
    @projects_invited_in.reset options.projects_invited_in

    @lists = new TodoList.Collections.ListsCollection()
    @lists.reset options.lists

    @project_lists = new TodoList.Collections.ListsCollection()

  routes:
    "/projects/new"             : "newProject"
    "/projects/index"           : "index"
    "/projects/:id/edit"        : "edit"
    "/projects/:id/lists"       : "showProjectLists"
    "/projects"                 : "index"
    "/projects/.*"              : "index"
    "/projects/:id/lists/new"   : "newProjectList"

    "/lists/new"        : "newList"
    "/lists/index"      : "indexList"
    "/lists/:id/edit"   : "editList"
    "/lists/:id"        : "showListTask"
    "/lists/.*"         : "indexList"
    "/lists"            : "indexList"


  newProject: ->
    @view = new TodoList.Views.Projects.NewView(collection: @projects)
    $("#app").html(@view.render().el)

  index: ->
    @view = new TodoList.Views.Projects.IndexView(projects: @projects, projects_invited_in: @projects_invited_in)
    $("#app").html(@view.render().el)

  showProjectLists: (id) ->
    if  !@projects.get(id)
      project = @projects_invited_in.get(id)
    else
      project = @projects.get(id)

    @project_lists.reset @lists.select((list) -> list.get("project_id")== project.attributes.id)
    @view = new TodoList.Views.Lists.IndexView(lists: @project_lists, project: project)
    $("#app").html(@view.render().el)


  edit: (id) ->
    project = @projects.get(id)

    @view = new TodoList.Views.Projects.EditView(model: project)
    $("#app").html(@view.render().el)

  newProjectList:(id) ->
    project = @projects.get(id)
    @view = new TodoList.Views.Lists.NewView(collection: @lists, project: project)
    $("#app").html(@view.render().el)

  newList: ->
    @view = new TodoList.Views.Lists.NewView(collection: @lists)
    $("#app").html(@view.render().el)

  indexList: ->
    @list_without_project =  new TodoList.Collections.ListsCollection()
    @list_without_project.reset @lists.select((list) -> list.get("project_id")==null)
    @view = new TodoList.Views.Lists.IndexView(lists: @lists)
    $("#app").html(@view.render().el)

  showList: (id) ->
    list = @lists.get(id)

    @view = new TodoList.Views.Lists.ShowView(model: list)
    $("#app").html(@view.render().el)

  editList: (id) ->
    list = @lists.get(id)

    @view = new TodoList.Views.Lists.EditView(model: list)
    $("#app").html(@view.render().el)
