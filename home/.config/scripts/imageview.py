#!/usr/bin/env python

from __future__ import print_function

import os
import sys
import subprocess

try:
    first_image = sys.argv[1]
except IndexError:
    print ("Usage: imageview image.ext")
    sys.exit(1)

VALID_EXTS = [
        "jpg",
        "gif",
        "jpeg",
        "png",
        "tiff",
        "tif",
        "tga",
        "targa",
        "bmp",
        "xcf",
        "ico"
    ]

if first_image.startswith("~"):
    first_image = os.path.expanduser(first_image)
first_image = os.path.abspath(first_image)
directory = os.path.dirname(first_image)

pre = []
post = []
at = False
for fname in sorted(os.listdir(directory)):
    if os.path.splitext(fname)[1].lower().lstrip(".") not in VALID_EXTS:
        continue
    fname = os.path.join(directory, fname)

    if fname == first_image:
        at = True
        continue
    if at:
        pre.append(os.path.abspath(fname))
    else:
        post.append(os.path.abspath(fname))

cmd = ["feh", "-FB", "black", "-q", "--draw-tinted", "--auto-rotate"]
cmd.append(first_image)
cmd.extend(pre)
cmd.extend(post)
p = subprocess.Popen(cmd)
p.wait()

