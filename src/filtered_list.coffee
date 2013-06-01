###
This is filtered list example
###

_         = require 'lodash'

AppLayout = require './filtered_list/app_layout'

BaseModel = require './filtered_list/base_model'

ItemViewModel      = require './filtered_list/item_vm'
ItemCollection    = require './filtered_list/item_collection'
ItemCollectionView = require './filtered_list/item_collection_view'

InputViewModel  = require './filtered_list/input_vm'
InputView       = require './filtered_list/input_view'

AllItemCollectionView = require './filtered_list/all_item_collection_view'

buildFakeData = (num) ->
  _.times num, ->
    text : Faker.Name.findName()


init_fn = (main_elem) ->

  layout = new AppLayout
  layout.render()
  $(main_elem).append layout.el

  data = buildFakeData 80
  
  base_model = new BaseModel { data }


  input_vm  = new InputViewModel base_model
  item_vm   = new ItemViewModel base_model

  models = new ItemCollection item_vm.get 'data'
  # its only one interaction point 
  # on 400 elements reset tooks only 50-100ms
  # and up to 800ms to render long list
  item_vm.on 'change:data', -> models.reset item_vm.get 'data'

  models2 = new ItemCollection item_vm.get 'data'

  layout.inputRegion.show new InputView model : input_vm
  layout.contentRegion.show new ItemCollectionView collection: models
  layout.dataRegion.show new AllItemCollectionView collection: models2

module.exports = init_fn