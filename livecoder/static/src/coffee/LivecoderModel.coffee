define [
  "d3"
  "underscore"
  "widgets/js/widget"
  "base/js/namespace"
],
(d3, _, widget, {notebook})->
  if "livecoder" not of notebook.metadata
    notebook.metadata.livecoder = {}

  metadata = notebook.metadata.livecoder

  class LivecoderModel extends widget.WidgetModel
    get_state: =>
      state = super()
      metadata[@get "description"] = _.pick state, [
        "_html"
        "_script"
        "_style"
      ]
      state

    set_state: (state) =>
      super(state).then => @set metadata[@get "description"]
