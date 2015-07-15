#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools import setup

try:
    from jupyterpip import cmdclass
except:
    import pip
    import importlib
    pip.main(["install", "jupyter-pip"])
    cmdclass = importlib.import_module("jupyterpip").cmdclass

setup(
    name="ipylivecoder",
    version="0.1.0",
    description="Live JavaScript coding against IPython widgets",
    author="Nicholas Bollweg",
    author_email="nick.bollweg@gmail.com",
    license="New BSD License",
    url="https://github.com/bollwyvl/nb-inkscapelayers",
    keywords="ipython js livecoding",
    install_requires=["ipython", "jupyter-pip"],
    classifiers=["Development Status :: 4 - Beta",
                 "Framework :: IPython",
                 "Programming Language :: Python",
                 "License :: OSI Approved :: MIT License"],
    packages=["livecoder"],
    include_package_data=True,
    cmdclass=cmdclass("livecoder/static/livecoder"),
)
