#!/bin/bash

# get latest autorelease build
curl -sS https://nexus.open-o.org/content/repositories/ | grep autorelease | sed 's|<[^>]*>||g' | sed -r 's|\s+||g' | cut -d/ -f 1 | sort | tail -1
