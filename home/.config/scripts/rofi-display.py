#!/usr/bin/env python3

import os
import subprocess
from subprocess import Popen, PIPE

layout_dir = os.path.expanduser("~/.screenlayout")

fdict = dict()

for f in os.listdir(layout_dir):
    fp = os.path.join(layout_dir, f)
    n = os.path.splitext(f)[0]
    fdict[n] = fp

lines = max(min(15, len(fdict)), 1);
width = len(max(fdict.keys(), key=len))

rofi = Popen([
            "rofi",
            "-i", "-dmenu",
            "-l", str(lines),
            "-width", str(width),
            "-p", "display configuration"
        ],
        stdout=PIPE,
        stdin=PIPE
    )
selected = rofi.communicate(
        "\n" \
        .join(sorted(fdict.keys())) \
        .encode("utf-8"))[0] \
        .decode("utf-8") \
        .strip()

rofi.wait()

r = subprocess.Popen([fdict[selected]])
r.wait()
