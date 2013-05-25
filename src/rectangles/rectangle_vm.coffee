###
This is passive VM example
###

Backbone.ViewModel = require 'backbone.viewmodel'

module.exports = class RectangleViewModel extends Backbone.ViewModel
  autoupdate : on
  mapping : 
    color   : 'color'
    width   : 'size'
    height  : 'getHeight'

  getHeight : ->
    @model.get('size') * ( 1 + Math.random() ) | 0