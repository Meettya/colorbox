###
This is Input view
###

Marionette      = require 'backbone.marionette'
input_template  = require './templates/input_tmpl'

module.exports = class InputView extends Marionette.ItemView
  template : input_template
  # add fadeout events - data mey be placed with mouse 'paste' command
  events:
    'keyup #filter-input'  : 'updateConfig'

  updateConfig: (e) =>
    @model.changeData 
      filter : $('#filter-input').val()
