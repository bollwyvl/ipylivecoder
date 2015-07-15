# ipylivecoder
> Live coding in the IPython notebook

IPython Widgets are perhaps one of the most powerful web interfaces to data available, but authoring them is fraught with peril. Take this!


## Installation
For now:
```bash
git clone https://github.com/bollwyvl/ipylivecoder.git
python setup.py develop
```

or

```bash
pip install https://github.com/bollwyvl/ipylivecoder.git#egg=ipylivecoder
```


## Usage
Currently `Livecoder` must be subclassed to do anything useful: a more pythonic builder interface is coming.

```python
from livecoder import Livecoder
from IPython.utils.traitlets import Float

class MyCoder(Livecoder):
  x = Float(sync=True)

live = Livecoder()
```



## Motivation
Writing one-off, data-driven widgets in the Jupyter Notebook is, to put it gently, _inconvenient_. To get the first data-drive pixel on the screen, you have to:
- write a python/julia/haskell/hy class
- write some javascript
  - understand backbone
  - if you do this in the notebook, all your errors get swallowed by the comm system
- if you choose to use a javascript editor...
  - package and install your script (`--symlink` helps)
  - frequently reload your browser page (hope you saved!)
- make an instance of the widget
- make some `traitlet.links` to anything you want to reuse (sliders, buttons)

## Inspiration
- [tributary.io](http://tributary.io)
- [_Inventing on Principal_](https://vimeo.com/36579366)
