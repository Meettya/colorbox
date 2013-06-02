###
This is view for Rectangle
###

Marionette        = require 'backbone.marionette'
resume_template   = require './templates/resume_tmpl'


module.exports = class ItemView extends Marionette.ItemView
  className : 'resume__box'
  template  : resume_template

  initialize: ->
    @model.on 'change', @render