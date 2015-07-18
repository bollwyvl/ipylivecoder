define [
  "./pane"
  "codemirror/mode/css/css"
],
({SourcePane})->
  class CSSPane extends SourcePane
    key: "style"
    attr: "_style"
    icon: "css3"
    label: "CSS"
    cm_opts:
      mode: "css"
