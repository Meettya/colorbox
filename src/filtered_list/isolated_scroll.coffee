###
Use this with jQuery Mouse Wheel Plugin
https://github.com/brandonaaron/jquery-mousewheel

TODO make it more solid with amd

###
((factory) ->
  if typeof exports is 'object'
    # Node/CommonJS
    factory require 'jquery'
  else if typeof define is "function" and define.amd
    # AMD. Register as an anonymous module.
    define ["jquery"], factory
  else
    # Browser globals
    factory jQuery

) ($) ->
  $.fn.extend

    isolatedScroll : ->
      @on 'mousewheel', (evnt, delta, deltaX, deltaY) ->
        bottomOverflow  = @scrollTop + $(@).outerHeight() - @scrollHeight >= 0
        topOverflow     = @scrollTop <= 0

        if (deltaY < 0 && bottomOverflow) || (deltaY > 0 && topOverflow)
          evnt.preventDefault()

      this
