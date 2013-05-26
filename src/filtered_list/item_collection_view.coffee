###
This is Marionette collection view
###

Marionette    = require 'backbone.marionette'
ItemView      = require './item_view'

module.exports = class RectangleCollectionView extends Marionette.CollectionView
  tagName   : 'ul'
  className : 'sortable__container'
  itemView  : ItemView

  # our cool pager
  pager :
    start   : 0 
    by_page : 20
 

  initialize: ->
    @$el.sortable().disableSelection()

    # may be pull it to controller?
    @scrolled_ts = null
    @last_scrolled_ts = null

    @$el.on 'scroll', (evnt) =>  
      @scrolled_ts = evnt.timeStamp
      
    @$el.on 'mousewheel', (evnt, delta, deltaX, deltaY) => 
      if @scrolled_ts isnt @last_scrolled_ts
        console.log 'moved'
        @last_scrolled_ts = @scrolled_ts
      else
        console.log 'stopped'

      
      # console.log 'wheeled', evnt, delta, deltaX, deltaY, @scrolled_ts

  
  # Internal method to loop through each item in the
  # collection view and show it
  showCollection : (start = @pager.start, count = @pager.by_page) ->
    for idx in [start...count]
      if item = @collection.models[idx]
        Item_View = @getItemView item
        @addItemView item, Item_View, idx

      null
    null


