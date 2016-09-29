#!/usr/bin/env python
# pipe in binaries.csv from stdin

import sys, csv, subprocess

version = "1.0.0-SNAPSHOT"


with sys.stdin as f:
    reader = csv.DictReader(f)
    errors = 0

    items = []
    for row in reader:
        txt = """
    <dependency>
      <groupId>{}</groupId>
      <artifactId>{}</artifactId>
      <version>{}</version>
      <type>{}</type>
      <classifier>{}</classifier>
    </dependency>"""
        print txt.format(row["groupId"], row["artifactId"], version, row["extension"], row["classifier"])
        
