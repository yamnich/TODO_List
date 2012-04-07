TodoList.Views.Tasks ||= {}

class TodoList.Views.Tasks.NewView extends Backbone.View
  template: JST["backbone/templates/tasks/new"]

  events:
    "submit #new-task": "save"

  constructor: (options) ->

    super(options)
    @model = new @collection.model()
    @model.url = "/lists/#{@options.list.attributes.id}/tasks"
    @model.bind("change:errors", () =>
    this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.url = "/lists/#{@options.list.attributes.id}/tasks"
    @model.attributes.list_id = @options.list.attributes.id

    @collection.create(@model.toJSON(),
      success: (task) =>
        @model = task
        window.location.hash = "/lists/#{@options.list.attributes.id}/tasks"

      error: (task, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
