define [
  "d3"
  "underscore"
  "inlet"
  "backbone"
  "codemirror/lib/codemirror"
  "widgets/js/widget"
  "base/js/namespace"
  # silent
  "codemirror/mode/javascript/javascript"
  "codemirror/mode/css/css"
  "jshint"
  "codemirror/addon/lint/lint"
  "codemirror/addon/lint/javascript-lint"
  "codemirror/addon/fold/foldcode"
  "codemirror/addon/fold/foldgutter"
  "codemirror/addon/fold/brace-fold"
  "codemirror/addon/fold/comment-fold"
],
(d3, _, Inlet, Backbone, CodeMirror, widget, {notebook})->
  panes =
    html:
      icon: "html5"
      cm:
        mode: "xml"
    script:
      icon: "code"
      cm:
        mode: "javascript"
        lint: true
    style:
      icon: "css3"
      cm:
        mode: "css"

  class LivecoderView extends widget.WidgetView
    className: "livecoder container-fluid"

    render: =>
      notebook.keyboard_manager.register_events @$el

      @d3 = d3.select @el
        .style width: "100%"

      @$theme = d3.select "head"
        .append "link"
        .attr
          rel: "stylesheet"
          href: @theme()

      @$inRow = @d3.append "div"
        .classed
          row: 1
          "livecoder-in-row": 1

      @$bar = @d3.append "div"
        .classed "col-md-6": 1
        .append "div"
        .classed "btn-group": 1

      @$btn = @$bar.selectAll ".btn"
        .data d3.entries panes
        .enter()
          .append "button"
          .classed
            btn: 1
            "btn-default": 1
            "btn-mini": 1
          .call (btn) ->
            btn.append "i"
              .attr
                "class": (d) -> "fa-#{d.value.icon}"
              .classed
                fa: 1
                "fa-fw": 1
            btn.append "span"
              .text ({key}) -> key
          .on "click", (d) =>
            @m "_active", d.key

      @$outRow = @d3.append "div"
        .classed
          row: 1
          "livecoder-out-row": 1

      @$out = @$outRow.append "div"
        .classed
          "col-md-12": 1

      @$iframe = @$out.append "iframe"
        .attr src: "/nbextensions/livecoder/iframe.html"
        .on "load", @iframeLoaded()

      _.defer @update

    update: =>
      @updateButtons()

      @initCodeMirror() unless @cm

      if "_theme" of @model.changed
        @$theme.attr href: @theme()
        for pane, cm of @cm
          cm.setOption "theme", @m "_theme"

    updateButtons: =>
      active = (@m "_active") or "script"
      @$btn.classed
        active: ({key}) -> key == active

    theme: =>
      "/static/components/codemirror/theme/#{@m '_theme'}.css"

    iframeLoaded: =>
      view = @
      -> @contentWindow._livecoder = view.model

    initCodeMirror: =>
      @cm = {}

      d3.entries(panes).map ({key, value}) =>
        div = @$inRow.append "div"
          .classed "col-md-4": 1
        cm = @cm[key] = new CodeMirror div.node(),
          _.extend {}, value.cm,
            value: if value.value
              value.value.call @
            else
              @m "_#{key}"
            gutters: ["CodeMirror-lint-markers"]
            theme: @m "_theme"
            matchBrackets: true
            autoCloseBrackets: true
            foldGutter: true
            tabSize: 2
            extraKeys: Tab: (cm) ->
              cm.replaceSelection Array(cm.getOption("indentUnit") + 1).join " "

        Inlet cm

        cm.on "change", =>
          @m "_#{key}", cm.getValue()
          @touch()

        _.delay (-> cm.refresh()), 200


    m: (name, val) =>
      if arguments.length == 1
        if typeof name is "string"
          return @model.get name
        @model.set name
        return @
      @model.set name, val
      return @
