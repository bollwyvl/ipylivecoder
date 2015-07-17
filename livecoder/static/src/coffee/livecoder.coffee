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
  fn = ->

  setHTML = ->
    d3.select "body"
      .html lvc.get "_html"

  setScript = ->
    src = """
      require(["#{ext}/lib/d3/d3.min.js"], function(d3){
        #{lvc.get "_script"}
      });
    """
    try
      fn = construct Function, ["model"].concat [src]
    catch err
      console.log err.message

  setStyle = ->
    d3.select "head"
      .selectAll "style"
      .data [1]
      .call (style)->
        style.enter().append "style"
      .html lvc.get "_style"

  runScript = ->
    try
      fn.apply window, [lvc]
    catch err
      console.log "execution errr", err

  update = ->
    changed = lvc.changed
    setStyle() unless "_style" not of changed
    setHTML() unless "_html" not of changed
    setScript() unless "_script" not of changed
    runScript()

  lvc.on "change", update

  # initialize
  setHTML()
  setStyle()
  setScript()
  runScript()
