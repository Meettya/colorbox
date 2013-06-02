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
  @PAGER_SETTING :
    start   : 0 
    by_page : 15
 
  initialize: ->
    @$el.sortable().disableSelection()
    @$el.isolatedScroll()
    # get from class data
    @pager = _.cloneDeep @constructor::constructor.PAGER_SETTING
    @_down_counter_ = 0
    @_is_real_event = false
 
  onBeforeRender: ->
    console.log 'onBeforeRender'
    @_down_counter_ = 0
    @$el.children().waypoint 'destroy'
    @$el.scrollTop(0)

  onRender: ->
    console.log 'onRender'

    doLog = (dir) => 

      unless @_is_real_event
        @_is_real_event = true
        return null

      if dir is 'down'
        @$el.find(':last-child').waypoint 'destroy'

        if ( @showCollection ++@_down_counter_ * @pager.by_page )
          @$el.find(':last-child').waypoint handler : doLog, context : 'ul',  offset: '100%'
      
    @$el.find(':last-child').waypoint handler : doLog, context : 'ul',  offset: '100%'


  # Internal method to loop through each item in the
  # collection view and show it
  showCollection : (start = @pager.start, count = @pager.by_page) ->
    for idx in [start...start + count]
      if item = @collection.models[idx]
        Item_View = @getItemView item
        @addItemView item, Item_View, idx
      else 
        return false
      null
    null

    true



    


