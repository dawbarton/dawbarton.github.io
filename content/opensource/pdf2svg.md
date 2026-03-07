---
title: "PDF2SVG"
---

> **Note:** Since this utility was written, the maintainers of [Poppler](https://poppler.freedesktop.org/) have released `pdftocairo`, which works on the same principle and is better maintained. **I recommend using `pdftocairo` instead.** pdf2svg is still available but is no longer actively developed.

A small program that converts a page of a PDF file into a Scalable Vector Graphics (SVG) file for editing in Inkscape. It wraps [Poppler](https://poppler.freedesktop.org/) and [Cairo](https://www.cairographics.org/) and was quite popular when it was written, as there were few other utilities available at the time.

## Installing

1. Download [pdf2svg](https://github.com/dawbarton/pdf2svg/releases/latest).
1. Unpack the files and build the executable.

```plaintext
tar -zxf pdf2svg-0.2.3.tar.gz
cd pdf2svg-0.2.3
./configure --prefix=/usr/local
make
make install
```

## Usage

```plaintext
pdf2svg <input.pdf> <output.svg> [<pdf page no. or "all">]
```

## Source code and binaries

Source code is on [GitHub](https://github.com/dawbarton/pdf2svg/). pdf2svg is packaged for various Linux distributions (including Ubuntu and Fedora) and is available via the standard package managers.

Windows binaries are available from [GitHub](https://github.com/jalios/pdf2svg-windows) (32-bit and 64-bit).

## Updates

* 2015-06-16 (v0.2.3): Minor updates.
* 2013-07-18 (v0.2.2): Updated renderer call — bitmaps now appear at full resolution.

## Copyright

Copyright &copy; 2007&ndash;2015 David Barton  
Copyright &copy; 2007 Matthew Flaschen (all-pages support)  
Copyright &copy; 2008 Ed Grace (GNU Autotools)
