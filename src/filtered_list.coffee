###
This is filtered list example
###

# TODO move it to jQuery plugin 
require './filtered_list/isolated_scroll'

_         = require 'lodash'

AppLayout = require './filtered_list/app_layout'

BaseModel         = require './filtered_list/base_model'
EmptyModel        = require './filtered_list/empty_model'

ItemViewModel      = require './filtered_list/item_vm'
ItemCollection    = require './filtered_list/item_collection'
ItemCollectionView = require './filtered_list/item_collection_view'

InputViewModel  = require './filtered_list/input_vm'
InputView       = require './filtered_list/input_view'

ResumeTextView  = require './filtered_list/resume_text_view'

buildFakeData = (num) ->
  _.times num, ->
    text : Faker.Name.findName()

FAKE_COUNT = 1024

init_fn = (main_elem) ->

  layout = new AppLayout
  layout.render()
  $(main_elem).append layout.el

  data = buildFakeData FAKE_COUNT
  
  base_model = new BaseModel { data }

  resume_model = new EmptyModel total : FAKE_COUNT, filtered : FAKE_COUNT

  input_vm  = new InputViewModel base_model
  item_vm   = new ItemViewModel base_model

  models = new ItemCollection item_vm.get 'data'
  # its only one interaction point 
  # on 400 elements reset tooks only 50-100ms
  # and up to 800ms to render long list
  item_vm.on 'change:data', -> 
    console.time 'change:data'
    models.reset item_vm.get 'data'
    console.timeEnd 'change:data'
    # add some statistics
    resume_model.set 'filtered', _.size item_vm.get 'data'


  layout.inputRegion.show new InputView model : input_vm
  console.time 'part'
  layout.contentRegion.show new ItemCollectionView collection: models
  console.timeEnd 'part'
  layout.dataRegion.show new ResumeTextView model : resume_model


module.exports = init_fn