// Generated by CoffeeScript 1.9.3
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty,
    slice = [].slice;

  define(["d3", "underscore", "backbone", "widgets/js/widget", "base/js/namespace"], function(d3, _, Backbone, widget, arg) {
    var LivecoderView, keyboard_manager, notebook, pager;
    notebook = arg.notebook;
    keyboard_manager = notebook.keyboard_manager;
    pager = keyboard_manager.pager;
    return LivecoderView = (function(superClass) {
      extend(LivecoderView, superClass);

      function LivecoderView() {
        this.m = bind(this.m, this);
        this.iframeLoaded = bind(this.iframeLoaded, this);
        this.theme = bind(this.theme, this);
        this.updateButtons = bind(this.updateButtons, this);
        this.update = bind(this.update, this);
        this.render = bind(this.render, this);
        return LivecoderView.__super__.constructor.apply(this, arguments);
      }

      LivecoderView.prototype.className = "livecoder container-fluid";

      LivecoderView.prototype.paneModules = ["livecoder/js/HTMLPane", "livecoder/js/JSPane", "livecoder/js/CSSPane"];

      LivecoderView.prototype.render = function() {
        keyboard_manager.register_events(this.$el);
        d3.select("body").classed({
          livecoding: 1
        });
        this.d3 = d3.select(this.el).style({
          width: "100%"
        });
        this.$theme = d3.select("head").append("link").attr({
          rel: "stylesheet",
          href: this.theme()
        });
        this.$outRow = this.d3.append("div").classed({
          row: 1,
          "livecoder-out-row": 1
        });
        this.$bar = this.d3.append("div").classed({
          "col-md-12": 1
        }).append("div").classed({
          "btn-toolbar": 1
        });
        this.$inRow = this.d3.append("div").classed({
          "livecoder-in-row": 1,
          "col-md-12": 1
        }).style({
          display: "flex",
          "flex-direction": "row"
        });
        this.$out = this.$outRow.append("div").classed({
          "col-md-12": 1
        });
        this.$iframe = this.$out.append("iframe").attr({
          src: "/nbextensions/livecoder/iframe.html"
        }).on("load", this.iframeLoaded());
        return require(this.paneModules, (function(_this) {
          return function() {
            var Pane, active, panes;
            panes = 1 <= arguments.length ? slice.call(arguments, 0) : [];
            _this.panes = (function() {
              var i, len, results;
              results = [];
              for (i = 0, len = panes.length; i < len; i++) {
                Pane = panes[i];
                results.push(new Pane());
              }
              return results;
            })();
            active = _this.m("_active") || {};
            _this.$btn = _this.$bar.append("div").classed({
              "btn-group": 1,
              "btn-group-xs": 1
            }).selectAll(".btn").data(_this.panes).enter().append("button").classed({
              btn: 1,
              "btn-default": 1,
              "btn-mini": 1
            }).call(function(btn) {
              btn.append("i").attr({
                "class": function(arg1) {
                  var icon;
                  icon = arg1.icon;
                  return "fa-" + icon;
                }
              }).classed({
                fa: 1,
                "fa-fw": 1
              });
              return btn.append("span").text(function(arg1) {
                var label;
                label = arg1.label;
                return label;
              });
            }).on("click", function(arg1) {
              var key;
              key = arg1.key;
              active = _this.m("_active") || {};
              active[key] = !active[key];
              _this.m("_active", _.extend({}, active));
              return _this.update();
            }).each(function(pane) {
              var div;
              div = _this.$inRow.append("div").style({
                "flex": +active[pane.key]
              }).classed({
                hide: !active[pane.key]
              });
              return pane.init(div, _this);
            });
            return _.defer(_this.update);
          };
        })(this));
      };

      LivecoderView.prototype.update = function() {
        this.updateButtons();
        if ("_theme" in this.model.changed) {
          return this.$theme.attr({
            href: this.theme()
          });
        }
      };

      LivecoderView.prototype.updateButtons = function() {
        var active, view;
        active = this.m("_active") || {};
        view = this;
        return this.$btn.classed({
          active: function(arg1) {
            var key;
            key = arg1.key;
            return active[key];
          }
        }).each(function(pane) {
          this.blur();
          if (pane.cm) {
            return d3.select(pane.cm.display.wrapper.parentNode).transition().style({
              flex: +active[pane.key]
            }).transition().each(function() {
              d3.select(this).classed({
                hide: !active[pane.key]
              });
              return _.defer(function() {
                return pane.cm.refresh();
              });
            });
          }
        });
      };

      LivecoderView.prototype.theme = function() {
        return "/static/components/codemirror/theme/" + (this.m('_theme')) + ".css";
      };

      LivecoderView.prototype.iframeLoaded = function() {
        var view;
        view = this;
        return function() {
          return this.contentWindow._livecoder = view.model;
        };
      };

      LivecoderView.prototype.m = function(name, val) {
        if (arguments.length === 1) {
          if (typeof name === "string") {
            return this.model.get(name);
          }
          this.model.set(name);
          return this;
        }
        this.model.set(name, val);
        return this;
      };

      return LivecoderView;

    })(widget.WidgetView);
  });

}).call(this);
