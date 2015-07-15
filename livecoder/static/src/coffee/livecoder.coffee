sc = "/static/components"
ext = "/nbextensions/livecoder"

require [
  "#{sc}/underscore/underscore-min.js"
  "#{sc}/backbone/backbone-min.js"
],
(_, Backbone) ->
  construct = (constructor, args) ->
    Factory = constructor.bind.apply constructor, [null].concat args
    new Factory()

  lvc = window._livecoder
  fn = null

  update = =>
    if "script" of lvc.changed
      src = """
        require(["#{ext}/lib/d3/d3.min.js"], function(d3){
          #{lvc.get "script"}
        });
      """
      try
        fn = construct Function, ["model"].concat [src]
      catch err
        console.log err.message

    try
      fn.apply window, [lvc]
    catch err
      console.log "execution errr", err

  lvc.on "change", update
