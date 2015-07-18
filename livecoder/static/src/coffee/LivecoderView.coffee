define [
  "d3"
  "underscore"
  "backbone"
  "widgets/js/widget"
  "base/js/namespace"
  # silent
],
(d3, _, Backbone, widget, {notebook})->
  {keyboard_manager} = notebook
  {pager} = keyboard_manager

  class LivecoderView extends widget.WidgetView
    className: "livecoder container-fluid"
    paneModules: [
      "livecoder/js/HTMLPane"
      "livecoder/js/JSPane"
      "livecoder/js/CSSPane"
    ]

    render: =>
      keyboard_manager.register_events @$el

      d3.select "body"
        .classed livecoding: 1

      @d3 = d3.select @el
        .style width: "100%"

      @$theme = d3.select "head"
        .append "link"
        .attr
          rel: "stylesheet"
          href: @theme()

      @$outRow = @d3.append "div"
        .classed
          row: 1
          "livecoder-out-row": 1

      @$bar = @d3.append "div"
        .classed "col-md-12": 1
        .append "div"
        .classed "btn-toolbar": 1

      @$inRow = @d3.append "div"
        .classed
          "livecoder-in-row": 1
          "col-md-12": 1
        .style
          display: "flex"
          "flex-direction": "row"

      @$out = @$outRow.append "div"
        .classed
          "col-md-12": 1

      @$iframe = @$out.append "iframe"
        .attr src: "/nbextensions/livecoder/iframe.html"
        .on "load", @iframeLoaded()

      require @paneModules, (panes...) =>
        @panes = (new Pane() for Pane in panes)
        active = @m("_active") || {}

        @$btn = @$bar
          .append "div"
          .classed
            "btn-group": 1
            "btn-group-xs": 1
          .selectAll ".btn"
        .data @panes
        .enter()
          .append "button"
          .classed
            btn: 1
            "btn-default": 1
            "btn-mini": 1
          .call (btn) ->
            btn.append "i"
              .attr
                "class": ({icon}) -> "fa-#{icon}"
              .classed
                fa: 1
                "fa-fw": 1
            btn.append "span"
              .text ({label}) -> label
          .on "click", ({key}) =>
            active = @m("_active") or {}
            active[key] = not active[key]
            @m "_active", _.extend({}, active)
            @update()
        .each (pane) =>
          div = @$inRow.append "div"
            .style "flex": +active[pane.key]
            .classed hide: not active[pane.key]
          pane.init div, @

        _.defer @update

    update: =>
      @updateButtons()

      if "_theme" of @model.changed
        @$theme.attr href: @theme()

    updateButtons: =>
      active = @m("_active") or {}
      view = @
      @$btn
        .classed
          active: ({key}) -> active[key]
        .each (pane) ->
          @blur()
          if pane.cm
            d3.select pane.cm.display.wrapper.parentNode
              .transition()
              .style flex: +active[pane.key]
              .transition()
              .each ->
                d3.select @
                  .classed hide: not active[pane.key]
                _.defer -> pane.cm.refresh()

    theme: =>
      "/static/components/codemirror/theme/#{@m '_theme'}.css"

    iframeLoaded: =>
      view = @
      -> @contentWindow._livecoder = view.model

    m: (name, val) =>
      if arguments.length == 1
        if typeof name is "string"
          return @model.get name
        @model.set name
        return @
      @model.set name, val
      return @
