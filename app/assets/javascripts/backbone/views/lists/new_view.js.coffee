TodoList.Views.Lists ||= {}

class TodoList.Views.Lists.NewView extends Backbone.View
  template: JST["backbone/templates/lists/new"]

  events:
    "submit #new-list": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    if @options.project
      @model.attributes.project_id = @options.project.attributes.id

    @collection.create(@model.toJSON(),
      success: (list) =>
        @model = list
        if @options.project
          window.location.hash = "/projects/#{@options.project.attributes.id}/lists"
        else
          window.location.hash = "/lists"
      error: (list, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
