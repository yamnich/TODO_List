TodoList.Views.Lists ||= {}

class TodoList.Views.Lists.ListView extends Backbone.View
  template: JST["backbone/templates/lists/list"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
