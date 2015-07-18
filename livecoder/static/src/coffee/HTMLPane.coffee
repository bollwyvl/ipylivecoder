define [
  "./pane"
],
({SourcePane})->
  class HTMLPane extends SourcePane
    key: "html"
    attr: "_html"
    icon: "html5"
    label: "HTML"
    cm_opts:
      mode: "xml"
