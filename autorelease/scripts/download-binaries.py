#!/usr/bin/env python
# pipe in binaries.csv from stdin

import sys, csv, subprocess

root = subprocess.check_output(["git", "rev-parse", "--show-toplevel"]).rstrip()
path = "{}/autorelease/dist".format(root)
version = "1.1.0-SNAPSHOT"
url_template = "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g={0}&a={1}&e={2}&c={3}&v=LATEST"

subprocess.call(["rm", "-rf", path])
subprocess.call(["mkdir", "-p", path])


def parseRow(row):
    service = row["service"]
    filename = row["filename"]
    groupId = row["groupId"]
    artifactId = row["artifactId"]
    extension = row["extension"]
    classifier = row["classifier"]
    url = url_template.format(groupId, artifactId, extension, classifier)
    if classifier:
        dest = "{}/{}-{}.{}.{}".format(path, filename, version, classifier, extension)
    else:
        dest = "{}/{}-{}.{}".format(path, filename, version, extension)
    return {"url": url, "dest": dest}


with sys.stdin as f:
    reader = csv.DictReader(f)
    errors = 0

    items = []
    for row in reader:
        item = parseRow(row)
        items.append(item)

        result = subprocess.call(["wget", "-q", "--spider", "--content-disposition", "-O", item["dest"], item["url"]])
        if result == 0:
            print "{} OK".format(row["service"])
        else:
            ++errors
            print "ERROR: {}".format(row["service"])

    print "{} errors found".format(errors)

    if errors == 0:
        for item in items:
            subprocess.call(["wget", "--content-disposition", "-O", item["dest"], item["url"]])
