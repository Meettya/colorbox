###
This is example of Backbone.ViewModel usage
###
_         = require 'lodash'

AppLayout = require './rectangles/app_layout'

BaseModel = require './rectangles/base_model'

RectangleViewModel      = require './rectangles/rectangle_vm'
RectanglesCollection    = require './rectangles/rectangles_collection'
RectangleCollectionView = require './rectangles/rectangle_collection_view'

InputViewModel  = require './rectangles/input_vm'
InputView       = require './rectangles/input_view'


init_fn = (main_elem, init_model_state) ->

  layout = new AppLayout
  layout.render()
  $(main_elem).append layout.el

  base_model = new BaseModel init_model_state

  input_vm = new InputViewModel base_model
  # prepare collections - re-write it better
  models = new RectanglesCollection _.times 5, -> new RectangleViewModel base_model

  layout.inputRegion.show new InputView model : input_vm
  layout.contentRegion.show new RectangleCollectionView collection: models

  null

module.exports = init_fn

   