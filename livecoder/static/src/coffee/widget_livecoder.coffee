ext = "/nbextensions/livecoder"

require.config
  paths:
    d3: "#{ext}/lib/d3/d3"
    inlet: "#{ext}/lib/inlet/inlet"
    jshint: "#{ext}/lib/jshint"
    livecoder: "#{ext}"
  shim:
    inlet:
      exports: "Inlet"

define [
  "d3"
  "./LivecoderView.js"
  "./LivecoderModel.js"
],
(d3, LivecoderView, LivecoderModel)->
  css = "#{ext}/css/livecoder.css"

  d3.select "head"
    .selectAll "link[href='#{css}']"
    .data [1]
    .enter()
    .append "link"
    .attr
      rel: "stylesheet"
      href: css

  {
    LivecoderView
    LivecoderModel
  }
