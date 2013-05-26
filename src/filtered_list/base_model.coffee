###
This is dystrophic base Model 
###

Backbone = require 'backbone'

module.exports = class BaseModel extends Backbone.Model
  # just to be sure its have some values
  defaults : 
    filter  : ''
    data    : []


    