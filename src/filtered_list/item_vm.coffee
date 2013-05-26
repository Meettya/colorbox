###
This is passive VM example
###

_         = require 'lodash'

Backbone.ViewModel = require 'backbone.viewmodel'

module.exports = class ItemViewModel extends Backbone.ViewModel
  autoupdate : on
  mapping : 
    filter   : 'buildFilter'
    data     : 'getFilteredData'

  buildFilter : ->
    new RegExp @model.get('filter'), 'i'

  getFilteredData : ->
    reFilter = @get 'filter'
    _.filter @model.get('data'), (element) ->
      reFilter.test element.text
