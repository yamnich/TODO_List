TodoList.Views.Tasks ||= {}

class TodoList.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  events:
    "click .destroy" : "destroy"
    "click .change_state": "change_state"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  change_state: (e) ->
    #e.preventDefault()
    #e.stopPropagation()

    @model.url =   @model.url = '/lists/'+@model.attributes.list_id+'/tasks/'+@model.attributes.id
    if @model.attributes.state == "done"
      @model.attributes.state = "in_work"
    else
      @model.attributes.state = "done"

    @model.save(null,
      success : (task) =>
        @model = task
        window.location.hash = "/lists/#{@model.attributes.list_id}/tasks"
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
