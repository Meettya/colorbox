###
This is our collections for items
###

Backbone = require 'backbone'
ItemViewModel = require './item_vm'

module.exports = class ItemsCollection extends Backbone.Collection

  constructor : (raw_model, options...) ->
    @_item_vm_  = new ItemViewModel raw_model
    super @_item_vm_.get('data'), options...

  initialize: ->
    @_item_vm_.on 'change:data', => 
      console.time 'change:data'
      @reset @_item_vm_.get 'data'
      @trigger 'change' # trigger custom event for consistency
      console.timeEnd 'change:data'

  comparator : (element) ->
    element.get 'text'