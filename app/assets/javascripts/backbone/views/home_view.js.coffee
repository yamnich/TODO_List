TodoList.Views.Home ||= {}

class TodoList.Views.Home.HomeView extends Backbone.View
  template: JST["backbone/templates/home"]

  render: ->
    $(@el).html(@template(@options.user.toJSON() ))
    @$("#projects_count").append("<a href = \"/#/projects\"> #{@options.projects.length} projects </a>")
    @$("#lists_count").append("<a href = \"/#/lists\"> #{@options.lists.length} lists </a>")
    @$("#projects_invited_in_count").append("<a href = \"/#/projects\"> #{@options.projects_invited_in.length} projects </a>")
    @$("#tasks_count").append("  #{@options.tasks.length} tasks ")
    return this
