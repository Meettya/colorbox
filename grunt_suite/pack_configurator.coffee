###
This is common package config
used in server and in build comand
###

path = require 'path'
root_path = path.join  __dirname, '..'

get_pack_config = (filename) ->

  switch filename
    when 'example'
      package_name : 'ExamplePackage'
      bundle : 
        boxer : path.join root_path, "src", filename


    else
      throw Error "dont know |#{filename}| settings"

module.exports = {
  get_pack_config
}