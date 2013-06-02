###
This is passive VM example
###

_             = require 'lodash'
escape_regexp = require 'escape-regexp'

Backbone.ViewModel = require 'backbone.viewmodel'

module.exports = class ItemViewModel extends Backbone.ViewModel
  autoupdate : on
  mapping : 
    filter   : 'buildFilter'
    data     : 'getFilteredData'

  buildFilter : ->
    new RegExp escape_regexp( @model.get('filter') ), 'i'

  getFilteredData : ->
    reFilter = @get 'filter'
    _.filter @model.get('data'), (element) ->
      reFilter.test element.text
