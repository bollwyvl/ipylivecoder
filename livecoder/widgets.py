import IPython.html.widgets as W
import IPython.utils.traitlets as T


class Livecoder(W.DOMWidget):
    _view_name = T.Unicode("LivecoderView", sync=True)
    _view_module = T.Unicode("/nbextensions/livecoder/js/widget_livecoder.js",
                             sync=True)

    style = T.Unicode(sync=True)
    script = T.Unicode(sync=True)
    html = T.Unicode(sync=True)
    width = T.Unicode("100%", sync=True)
