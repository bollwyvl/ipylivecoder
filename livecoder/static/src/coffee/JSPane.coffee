define [
  "./pane"
  "codemirror/mode/javascript/javascript"
  "jshint"
  "codemirror/addon/lint/javascript-lint"
],
({SourcePane})->
  class JSPane extends SourcePane
    key: "script"
    attr: "_script"
    icon: "code"
    label: "JS"
    cm_opts:
      mode: "javascript"
      lint: true
      gutters: ["CodeMirror-lint-markers"]
