###
This is view for Rectangle
###

Marionette        = require 'backbone.marionette'
item_template = require './templates/item_tmpl'

module.exports = class ItemView extends Marionette.ItemView
  tagName   : 'li'
  className : 'sortable__item'
  template  : item_template

