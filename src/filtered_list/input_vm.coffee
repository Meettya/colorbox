###
This is active VM
###

Backbone.ViewModel = require 'backbone.viewmodel'

module.exports = class InputViewModel extends Backbone.ViewModel
  mapping : 
    filter : 'filter'

  changeData : (new_data) =>
    @model.set new_data