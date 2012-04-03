TodoList.Views.Projects ||= {}

class TodoList.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]

  initialize: () ->
    @options.projects.bind('reset', @addAll)
    @options.projects_invited_in.bind('reset', @addAll)

  addAll: () =>
    @options.projects.each(@addOne)
    @options.projects_invited_in.each(@addOneProjectInvitedIn)

  addOne: (project) =>
    view = new TodoList.Views.Projects.ProjectView({model : project})
    @$("#projects").append(view.render().el)

  addOneProjectInvitedIn: (project) =>
    view = new TodoList.Views.Projects.ProjectView({model : project})
    @$("#projects_invited_in").append(view.render().el)

  render: =>
    $(@el).html(@template(projects: @options.projects.toJSON() ))
    @addAll()

    return this
