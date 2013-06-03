###
This is simply VM to encapsulate logic 
###

_             = require 'lodash'

Backbone.ViewModel = require 'backbone.viewmodel'

module.exports = class ResumeViewModel extends Backbone.ViewModel
  mapping : 
    total       : 'getTotalDataCount'
    filtered    : 'getFilteredDataCount'

  initialize: ->
    # custom property don't fire autoupdate :(
    @model.get('filtered_data').on 'change', => 
      # but we are have nice BB.VM method :)
      @update()

  getTotalDataCount : ->
    # do not recalculate it 
    @get('total') || @model.get('raw_data').length

  getFilteredDataCount : ->
    @model.get('filtered_data').length 

