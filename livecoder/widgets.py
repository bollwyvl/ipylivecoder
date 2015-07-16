import IPython.html.widgets as W
import IPython.utils.traitlets as T


class Livecoder(W.DOMWidget):
    _view_name = T.Unicode("LivecoderView", sync=True)
    _view_module = T.Unicode("/nbextensions/livecoder/js/widget_livecoder.js",
                             sync=True)

    _style = T.Unicode("/* CSS */", sync=True)
    _script = T.Unicode("/* JS */", sync=True)
    _html = T.Unicode("<!-- html -->", sync=True)
    _theme = T.Unicode("zenburn", sync=True)

    width = T.Unicode("100%", sync=True)
