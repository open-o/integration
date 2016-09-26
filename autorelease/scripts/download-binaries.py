#!/usr/bin/env python
# pipe in binaries.csv from stdin

import sys, csv, subprocess

root = subprocess.check_output(["git", "rev-parse", "--show-toplevel"]).rstrip()
path = "{}/autorelease/dist".format(root)

subprocess.call(["rm", "-rf", path])
subprocess.call(["mkdir", "-p", path])

with sys.stdin as f:
    reader = csv.reader(f)
    header = reader.next()

    version = "1.0.0-SNAPSHOT"
    url_template = "https://nexus.open-o.org/service/local/artifact/maven/redirect?r=snapshots&g={0}&a={1}&e={2}&c={3}&v=LATEST"
    
    for row in reader:
        filename = row[header.index("filename")]
        groupId = row[header.index("groupId")]
        artifactId = row[header.index("artifactId")]
        extension = row[header.index("extension")]
        classifier = row[header.index("classifier")]
        url = url_template.format(groupId, artifactId, extension, classifier)
        if classifier:
            dest = "{}/{}-{}.{}.{}".format(path, filename, version, classifier, extension)
        else:
            dest = "{}/{}-{}.{}".format(path, filename, version, extension)
                                
        subprocess.call(["wget", "--content-disposition", "-O", dest, url] )
