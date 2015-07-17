import time

import IPython.html.widgets as W
import IPython.utils.traitlets as T

_EXT = "/nbextensions/livecoder/js/widget_livecoder.js"


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

    width = T.Unicode("100%", sync=True)

    def __init__(self, *args, **kwargs):
        kwargs["description"] = kwargs.get(
            "description",
            "livecoder-widget-{}".format(int(time.time()))
        )
        super(Livecoder, self).__init__(*args, **kwargs)
