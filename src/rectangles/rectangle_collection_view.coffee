###
This is Marionette collection view
###

Marionette    = require 'backbone.marionette'
RectangleView = require './rectangle_view'

module.exports = class RectangleCollectionView extends Marionette.CollectionView
  itemView: RectangleView