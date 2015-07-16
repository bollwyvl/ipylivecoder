sc = "/static/components"
ext = "/nbextensions/livecoder"

require [
  "#{sc}/underscore/underscore-min.js"
  "#{ext}/lib/d3/d3.js"
  "#{sc}/backbone/backbone-min.js"
],
(_, d3, Backbone) ->
  construct = (constructor, args) ->
    Factory = constructor.bind.apply constructor, [null].concat args
    new Factory()

  lvc = window._livecoder
  fn = null

  update = =>
    if "_script" of lvc.changed
      src = """
        require(["#{ext}/lib/d3/d3.min.js"], function(d3){
          #{lvc.get "_script"}
        });
      """
      try
        fn = construct Function, ["model"].concat [src]
      catch err
        console.log err.message

    if "_style" of lvc.changed
      d3.select "head"
        .selectAll "style"
        .data [1]
        .call (style)->
          style.enter().append "style"
        .html lvc.get "_style"

    if "_html" of lvc.changed
      d3.select "body"
        .html lvc.get "_html"

    if fn
      try
        fn.apply window, [lvc]
      catch err
        console.log "execution errr", err

  lvc.on "change", update
