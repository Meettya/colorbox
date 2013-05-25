###
This is Input view
###

Marionette      = require 'backbone.marionette'
input_template  = require './templates/input_tmpl'

module.exports = class InputView extends Marionette.ItemView
  template : input_template
  events:
    'keyup #color-input'  : 'updateConfig'
    'keyup #size-input'   : 'updateConfig'

  updateConfig: (e) =>
    @model.changeData 
      color :  $('#color-input').val()
      size  :  $('#size-input').val()