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
    by_page : 8
 
  initialize: ->
    @$el.sortable().disableSelection()
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

      console.log @_down_counter_
      console.log 'doLog'

      
      unless @_is_real_event
        @_is_real_event = true
        return null

      if dir is 'down'
        console.log 'add part'


        console.log @$el.find(':last-child')

        @$el.find(':last-child').waypoint 'destroy'

        is_continues  = @showCollection ++@_down_counter_ * @pager.by_page

        console.log is_continues

        if is_continues

          console.log @$el.find(':last-child')

          @$el.find(':last-child').waypoint handler : doLog, context : 'ul',  offset: '100%', continuous: false
      

    @$el.find(':last-child').waypoint handler : doLog, context : 'ul',  offset: '100%'


  # Internal method to loop through each item in the
  # collection view and show it
  showCollection : (start = @pager.start, count = @pager.by_page) ->

    stop = start + count
    console.log 'showCollection'
    console.log start, stop

    for idx in [start...stop]
      if item = @collection.models[idx]
        Item_View = @getItemView item
        @addItemView item, Item_View, idx
      else 
        return false
      null
    null

    true



    


