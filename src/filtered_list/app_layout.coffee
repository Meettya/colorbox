###
This is Applicaton Layout
###

Marionette        = require 'backbone.marionette'
layout_template   = require './templates/layout_tmpl'

module.exports = class AppLayout extends Marionette.Layout
  template: layout_template
  regions: 
    inputRegion:    "#config-input"
    contentRegion:  "#sortable-box"
    dataRegion:     "#show-data"
