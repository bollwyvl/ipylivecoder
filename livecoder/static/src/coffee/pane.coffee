define [
  "underscore"
  "inlet"
  "codemirror/lib/codemirror"
  # silent upgrades
  "codemirror/addon/scroll/simplescrollbars"
  "codemirror/addon/lint/lint"
  "codemirror/addon/fold/foldcode"
  "codemirror/addon/fold/foldgutter"
  "codemirror/addon/fold/brace-fold"
  "codemirror/addon/fold/comment-fold"
], (_, Inlet, CodeMirror)->
  class Pane

  class SourcePane extends Pane
    cm_defaults:
      matchBrackets: true
      lineWrapping: true
      autoCloseBrackets: true
      foldGutter: true
      tabSize: 2
      scrollbarStyle: "simple"
      extraKeys: Tab: (cm) ->
        cm.replaceSelection Array(cm.getOption("indentUnit") + 1).join " "

    value: -> @model.get @attr

    init: (el, view) ->
      @model = view.model
      @cm = new CodeMirror el.node(),
        _.extend {}, @cm_defaults, @cm_opts,
          value: @value()
          theme: view.m "_theme"

      Inlet @cm

      view.listenTo @model, "change:_theme", =>
        @cm.setOption "theme", view.m "_theme"

      @cm.on "inputRead", =>
        view.m @attr, @cm.getValue()
        view.touch()

      _.delay (=> @cm.refresh()), 200

  {
    Pane
    SourcePane
  }
