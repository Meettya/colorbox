###
This is filtered list example
###

# TODO move it to jQuery plugin 
require './filtered_list/isolated_scroll'

_         = require 'lodash'

AppLayout = require './filtered_list/app_layout'

BaseModel = require './filtered_list/base_model'

ItemCollection      = require './filtered_list/item_collection'
ItemCollectionView  = require './filtered_list/item_collection_view'

InputViewModel  = require './filtered_list/input_vm'
InputView       = require './filtered_list/input_view'

ResumeViewModel = require './filtered_list/resume_vm'
ResumeTextView  = require './filtered_list/resume_text_view'

buildFakeData = (num) ->
  _.times num, ->
    text : Faker.Name.findName()

FAKE_COUNT = 1024

init_fn = (main_elem) ->

  layout = new AppLayout
  layout.render()
  $(main_elem).append layout.el

  # make data
  data = buildFakeData FAKE_COUNT
  
  # make base model from data
  base_model = new BaseModel { data }

  # build our viewmodels && collections models
  input_vm  = new InputViewModel base_model
  models    = new ItemCollection base_model
  resume_vm = new ResumeViewModel raw_data : data, filtered_data : models

  # show all
  layout.inputRegion.show   new InputView model : input_vm
  layout.contentRegion.show new ItemCollectionView collection: models
  layout.dataRegion.show    new ResumeTextView model : resume_vm


module.exports = init_fn