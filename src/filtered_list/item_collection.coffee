###
This is our collections for items
###

Backbone = require 'backbone'

module.exports = class ItemsCollection extends Backbone.Collection
  comparator : (element) ->
    element.get 'text'