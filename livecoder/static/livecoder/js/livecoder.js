// Generated by CoffeeScript 1.9.3
(function() {
  var ext, sc;

  sc = "/static/components";

  ext = "/nbextensions/livecoder";

  require([sc + "/underscore/underscore-min.js", sc + "/backbone/backbone-min.js"], function(_, Backbone) {
    var construct, fn, lvc, update;
    construct = function(constructor, args) {
      var Factory;
      Factory = constructor.bind.apply(constructor, [null].concat(args));
      return new Factory();
    };
    lvc = window._livecoder;
    fn = null;
    update = (function(_this) {
      return function() {
        var err, src;
        if ("script" in lvc.changed) {
          src = "require([\"" + ext + "/lib/d3/d3.min.js\"], function(d3){\n  " + (lvc.get("script")) + "\n});";
          try {
            fn = construct(Function, ["model"].concat([src]));
          } catch (_error) {
            err = _error;
            console.log(err.message);
          }
        }
        try {
          return fn.apply(window, [lvc]);
        } catch (_error) {
          err = _error;
          return console.log("execution errr", err);
        }
      };
    })(this);
    return lvc.on("change", update);
  });

}).call(this);