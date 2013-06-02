((factory) ->
  if typeof define is "function" and define.amd
    
    # AMD. Register as an anonymous module.
    define ["jquery"], factory
  else if typeof exports is "object"
    
    # Node/CommonJS style for Browserify
    module.exports = factory
  else
    
    # Browser globals
    factory jQuery
) ($) ->
  console.log "yes"

