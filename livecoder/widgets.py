import time

from jinja2 import Template

from IPython import display
import IPython.html.widgets as W
import IPython.utils.traitlets as T

from jinja2 import Environment, PackageLoader

_EXT = "/nbextensions/livecoder/js/widget_livecoder.js"

env = Environment(loader=PackageLoader("livecoder", "templates"))

class Livecoder(W.DOMWidget):
    _view_name = T.Unicode("LivecoderView", sync=True)
    _view_module = T.Unicode(_EXT, sync=True)

    _model_name = T.Unicode("LivecoderModel", sync=True)
    _model_module = T.Unicode(_EXT, sync=True)

    description = T.Unicode(sync=True)

    _style = T.Unicode("/* CSS */", sync=True)
    _script = T.Unicode("/* JS */", sync=True)
    _html = T.Unicode("<!-- html -->", sync=True)
    _theme = T.Unicode("zenburn", sync=True)
    _active = T.Dict({"script": True}, sync=True)

    width = T.Unicode("100%", sync=True)

    def __init__(self, *args, **kwargs):
        super(Livecoder, self).__init__(*args, **kwargs)

    def to_package(self):
        widget_src = env.get_template("widget.js").render(widget=self)

        return widget_src
