###
This is filtered list example
###

_         = require 'lodash'

AppLayout = require './rectangles/app_layout'

BaseModel = require './filtered_list/base_model'


init_fn = (main_elem, init_model_state) ->

  layout = new AppLayout
  layout.render()
  $(main_elem).append layout.el

  base_model = new BaseModel init_model_state

module.exports = init_fn