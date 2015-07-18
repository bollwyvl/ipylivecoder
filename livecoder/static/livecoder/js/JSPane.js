// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["./pane", "codemirror/mode/javascript/javascript", "jshint", "codemirror/addon/lint/javascript-lint"], function(arg) {
    var JSPane, SourcePane;
    SourcePane = arg.SourcePane;
    return JSPane = (function(superClass) {
      extend(JSPane, superClass);

      function JSPane() {
        return JSPane.__super__.constructor.apply(this, arguments);
      }

      JSPane.prototype.key = "script";

      JSPane.prototype.attr = "_script";

      JSPane.prototype.icon = "code";

      JSPane.prototype.label = "JS";

      JSPane.prototype.cm_opts = {
        mode: "javascript",
        lint: true,
        gutters: ["CodeMirror-lint-markers"]
      };

      return JSPane;

    })(SourcePane);
  });

}).call(this);
