###
This is Marionette collection view
###

Marionette    = require 'backbone.marionette'
ItemView      = require './item_view'

module.exports = class RectangleCollectionView extends Marionette.CollectionView
  tagName   : 'ol'
  className : 'sortable__container__big'
  itemView  : ItemView