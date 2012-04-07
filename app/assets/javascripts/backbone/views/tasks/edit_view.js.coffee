TodoList.Views.Tasks ||= {}

class TodoList.Views.Tasks.EditView extends Backbone.View
  template : JST["backbone/templates/tasks/edit"]

  events :
    "submit #edit-task" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (task) =>
        @model = task
        @collection.url = "/lists/#{@options.list.attributes.id}/tasks"
        window.location.hash = "/lists/#{@options.list.attributes.id}/tasks"

    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
