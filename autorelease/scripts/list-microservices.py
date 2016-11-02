#!/usr/bin/env python
# pipe in binaries.csv from stdin

import sys, csv, subprocess

with sys.stdin as f:
    reader = csv.DictReader(f)

    rows = []
    for row in reader:
        rows.append(row)

    for row in rows:
        print "  * {:35s}    {}".format(row["filename"], row["service"])
