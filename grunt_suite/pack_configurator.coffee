###
This is common package config
used in server and in build comand
###

path = require 'path'
root_path = path.join  __dirname, '..'

get_pack_config = (filename) ->

  switch filename
    when 'rectangles'
      package_name : 'ExamplePackage'
      bundle : 
        boxer : path.join root_path, "src", filename
      replacement :
        lodash    : path.join root_path, 'web_modules', 'lodash'        
        backbone  : path.join root_path, 'web_modules', 'backbone'
        'backbone.marionette' : path.join root_path, 'web_modules', 'backbone.marionette'
        'backbone.viewmodel'  : path.join root_path, 'web_modules', 'backbone.viewmodel'

    when 'filtered_list'
      package_name : 'ExamplePackage'
      bundle : 
        list_wiget : path.join root_path, "src", filename
      replacement :
        lodash    : path.join root_path, 'web_modules', 'lodash'        
        backbone  : path.join root_path, 'web_modules', 'backbone'
        'backbone.marionette' : path.join root_path, 'web_modules', 'backbone.marionette'
        'backbone.viewmodel'  : path.join root_path, 'web_modules', 'backbone.viewmodel'

    else
      throw Error "dont know |#{filename}| settings"

module.exports = {
  get_pack_config
}