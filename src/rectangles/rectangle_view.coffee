###
This is view for Rectangle
###

Marionette        = require 'backbone.marionette'
rectangle_template = require './templates/rectangle_tmpl'

module.exports = class RectangleView extends Marionette.ItemView
  tagName: 'li'
  template : rectangle_template
  initialize: ->
    @model.on 'change', @render