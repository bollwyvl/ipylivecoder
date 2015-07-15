define [
  "d3"
  "underscore"
  "inlet"
  "codemirror/lib/codemirror"
  "widgets/js/widget"
  "base/js/namespace"
  # silent
  "codemirror/mode/javascript/javascript"
],
(d3, _, Inlet, CodeMirror, widget, IPython)->
  class LivecoderView extends widget.DOMWidgetView
    className: "livecoder container-fluid"

    render: =>
      IPython.notebook.keyboard_manager.register_events @$el
      @d3 = d3.select @el
        .style width: "100%"

      @$row = @d3.append "div"
        .classed "row": 1

      @$out = @$row.append "div"
        .classed "col-md-6": 1

      @$iframe = @$out.append "iframe"
        .attr src: "/nbextensions/livecoder/iframe.html"
        .on "load", @iframeLoaded()

      @$in = @$row.append "div"
        .classed "col-md-6": 1

      _.defer @update

    update: =>
      @initCodeMirror() unless @cm

    iframeLoaded: =>
      view = @
      -> @contentWindow._livecoder = view.model

    initCodeMirror: =>
      @cm = new CodeMirror @$in.node(),
        mode: "javascript"
        value: @m("script") or ""
        lineNumbers: true

      Inlet @cm

      @cm.on "change", =>
        @m "script", @cm.getValue()
        @touch()

    m: (name, val) =>
      if arguments.length == 1
        if typeof name is "string"
          return @model.get name
        @model.set name
        return @
      @model.set name, val
      return @
