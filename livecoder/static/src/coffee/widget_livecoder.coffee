ext = "/nbextensions/livecoder"

require.config
  paths:
    d3: "#{ext}/lib/d3/d3"
    inlet: "#{ext}/lib/inlet/inlet"
  shim:
    inlet:
      exports: "Inlet"

define [
  "d3"
  "./LivecoderView.js"
],
(d3, LivecoderView)->
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
  }
