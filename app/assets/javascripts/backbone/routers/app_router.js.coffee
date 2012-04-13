class TodoList.Routers.AppRouter extends Backbone.Router

  initialize: (options) ->
    @users = new TodoList.Collections.UsersCollection()
    @users.reset options.user


    @projects = new TodoList.Collections.ProjectsCollection()
    @projects.reset options.projects

    @projects_invited_in = new TodoList.Collections.ProjectsCollection()
    @projects_invited_in.reset options.projects_invited_in

    @lists = new TodoList.Collections.ListsCollection()
    @lists.reset options.lists

    @project_lists = new TodoList.Collections.ListsCollection()

    @tasks = new TodoList.Collections.TasksCollection()
    @tasks.reset options.tasks

  routes:
    "/"                                :"homePage"
    ".*"                               :"homePage"

    "/projects/new"                    : "newProject"
    "/projects/index"                  : "indexProject"
    "/projects/:id/edit"               : "editProject"
    "/projects/:id/lists"              : "showProjectLists"
    "/projects"                        : "indexProject"
    "/projects/.*"                     : "indexProject"
    "/projects/:id/lists/new"          : "newProjectList"

    "/lists/new"                       : "newList"
    "/lists/index"                     : "indexList"
    "/lists/:id/edit"                  : "editList"
    "/lists/.*"                        : "indexList"
    "/lists"                           : "indexList"

    "/lists/:list_id/tasks/new"        : "newTask"
    "/lists/:list_id/tasks"            : "indexTask"
    "/lists/:list_id/tasks/:id/edit"   : "editTask"
    "/lists/:list_id/.*"               : "indexTask"
    "/lists/:list_id/"                 : "indexTask"
    "/lists/:list_id/tasks/done"       : "doneTask"
    "/lists/:list_id/tasks/inwork"     : "inworkTask"

  homePage:->
    @view = new TodoList.Views.Home.HomeView(projects: @projects, projects_invited_in: @projects_invited_in, lists: @lists, tasks:@tasks, user: @users.models[0])
    $("#app").html(@view.render().el)


  newProject: ->
    @view = new TodoList.Views.Projects.NewView(collection: @projects)
    $("#app").html(@view.render().el)

  indexProject: ->
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


  editProject: (id) ->
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

  ####TASK###

  newTask: (list_id) ->
    @view = new TodoList.Views.Tasks.NewView(collection: @tasks, list: @lists.get(list_id))
    $("#app").html(@view.render().el)

  indexTask: (list_id) ->
    list = @lists.get(list_id)

    @list_tasks = new TodoList.Collections.TasksCollection()
    @list_tasks.reset  @tasks.select((list_task) -> list_task.get("list_id") == list.attributes.id)
    @view = new TodoList.Views.Tasks.IndexView(tasks: @list_tasks, list: list)
    $("#app").html(@view.render().el)

  editTask: (list_id, id) ->
    task = @tasks.get(id)

    @view = new TodoList.Views.Tasks.EditView(model: task, list: @lists.get(list_id))
    $("#app").html(@view.render().el)

  doneTask: (list_id) ->
    list = @lists.get(list_id)

    @list_tasks = new TodoList.Collections.TasksCollection()
    @list_tasks.reset  @tasks.select((list_task) -> list_task.get("list_id") == list.attributes.id)
    @done_list_tasks = new TodoList.Collections.TasksCollection()
    @done_list_tasks.reset @list_tasks.select((done_list_task) -> done_list_task.get("state") == "done")
    @view = new TodoList.Views.Tasks.IndexView(tasks: @done_list_tasks, list: list)
    $("#app").html(@view.render().el)

  inworkTask: (list_id) ->
    list = @lists.get(list_id)

    @list_tasks = new TodoList.Collections.TasksCollection()
    @list_tasks.reset  @tasks.select((list_task) -> list_task.get("list_id") == list.attributes.id)
    @inwork_list_tasks = new TodoList.Collections.TasksCollection()
    @inwork_list_tasks.reset @list_tasks.select((inwork_list_task) -> inwork_list_task.get("state") == "in_work")
    @view = new TodoList.Views.Tasks.IndexView(tasks: @inwork_list_tasks, list: list)
    $("#app").html(@view.render().el)


