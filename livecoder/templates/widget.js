define([
  "underscore",
  "widgets/js/widget"
],
function(_, widget){
  "use strict";

  var Widget = widget.DOMWidgetView.extend({
    update: function(){
      {{ widget._script }}
    }
  });

  return {
    Widget: Widget
  };
});
