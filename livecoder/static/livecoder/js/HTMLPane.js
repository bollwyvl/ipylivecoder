// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["./pane"], function(arg) {
    var HTMLPane, SourcePane;
    SourcePane = arg.SourcePane;
    return HTMLPane = (function(superClass) {
      extend(HTMLPane, superClass);

      function HTMLPane() {
        return HTMLPane.__super__.constructor.apply(this, arguments);
      }

      HTMLPane.prototype.key = "html";

      HTMLPane.prototype.attr = "_html";

      HTMLPane.prototype.icon = "html5";

      HTMLPane.prototype.label = "HTML";

      HTMLPane.prototype.cm_opts = {
        mode: "xml"
      };

      return HTMLPane;

    })(SourcePane);
  });

}).call(this);