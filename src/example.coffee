###
This is example CoffeeScript file
###

class ConfigModel extends Backbone.Model
  initialize: ->
    @set color: 'blue', width: 100, height: 100

class ColorBoxView extends Backbone.View
  tagName: 'li'
  initialize: ->
    @template = $('#color-box-template').template()
    @model.bind 'change', @render

  render: =>
    @$el.html $.tmpl @template, @model.toJSON()
    this

class ConfigInputView extends Backbone.View
  events:
    'keyup #color-input': 'updateConfig'
    'keyup #width-input': 'updateConfig'

  updateConfig: (e) =>
    @model.set(
      color: $('#color-input').val(),
      width: $('#width-input').val(),
      height: $('#width-input').val()
    )

class ColorBoxController extends Backbone.Router
  initialize: ->
    model = new ConfigModel
    new ConfigInputView { model, el: $('#config-input')}
    for x in [1..5]
      view = new ColorBoxView { model }
      $('#color-boxes').append view.render().el

module.exports = -> new ColorBoxController

   