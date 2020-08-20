@def title = "David AW Barton &mdash; PDF2SVG"

# PDF2SVG

**Note:** since this utility was written, the maintainers of [Poppler](https://poppler.freedesktop.org/) have written a utility that works on the same principle: `pdftocairo`. I recommend that you use their utility since it is better maintained than mine.

Under Linux there aren’t many freely available vector graphics editors and as far as I know there are none that can edit EPS (encapsulated postscript) and PDF (portable document format) files. I produce lots of these files in my day-to-day work and I would like to be able to edit them. The best vector graphics editor I have found so far is [Inkscape](https://inkscape.org) but it only reads SVG files… (Edit: recent versions can import PDFs but I’m not entirely happy with how text is imported; in particular, that fonts are not imported from the PDF.)

To overcome this problem I have written a very small utility to convert PDF files to SVG files using [Poppler](https://poppler.freedesktop.org/) and [Cairo](https://www.cairographics.org/). Version 0.2.3 is available here (with modifications by Matthew Flaschen and Ed Grace). This appears to work on any PDF document that Poppler can read (try them in XPDF or Evince since they both use Poppler).

So now it is possible to easily edit PDF documents with your favourite SVG editor! One other alternative would be to use pstoedit but the commercial SVG module costs (unsurprisingly!) and the free SVG module is not very good at handling text… 

## Installing

1. Download [pdf2svg](https://github.com/dawbarton/pdf2svg/releases/latest).
1. Unpack the files and make the executable.

```plaintext
tar -zxf pdf2svg-0.2.3.tar.gz
cd pdf2svg-0.2.3
./configure --prefix=/usr/local
make
make install
```

## To use

```plaintext
pdf2svg &lt;input.pdf&gt; &lt;output.svg&gt; [&lt;pdf page no. or "all"&gt;]
```

## Source code

A Git repository is also available on [GitHub](https://github.com/dawbarton/pdf2svg/).

## Binaries

pdf2svg is packaged for various Linux distributions (including Ubuntu and Fedora) and is available via the different package managers.

Windows binaries are available from [GitHub](https://github.com/jalios/pdf2svg-windows); both 32 bit and 64 bit versions are available.

To cross compile for Windows under Linux, simply install the relevant cross-compiler packages (for Fedora this is mingw32-cairo and mingw32-poppler and their dependencies) and then replace `./configure` in the compilation instructions above with `mingw32-configure`.

# Updates

* 2015-06-16 (v0.2.3): Minor updates.
* 2013-07-18 (v0.2.2): Updated to use the correct renderer call — bitmaps should now appear at full resolution.

# Copyright

Copyright &copy; 2007-2015 David Barton

Copyright &copy; 2007 Matthew Flaschen; Updated to allow conversion of all pages at once.

Copyright &copy; 2008 Ed Grace; Added GNU Autotools commands.
