TodoList.Views.Lists ||= {}

class TodoList.Views.Lists.EditView extends Backbone.View
  template : JST["backbone/templates/lists/edit"]

  events :
    "submit #edit-list" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (list) =>
        @model = list
        if @model.attributes.project_id
          window.location.hash = "/projects/#{@model.attributes.project_id}/lists"
        else
          window.location.hash = "/lists"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
