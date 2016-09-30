#!/usr/bin/env python
# pipe in binaries.csv from stdin

import sys, csv, subprocess

version = "1.0.0-SNAPSHOT"


with sys.stdin as f:
    reader = csv.DictReader(f)

    print """
<assembly xmlns="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/plugins/maven-assembly-plugin/assembly/1.1.0 http://maven.apache.org/xsd/assembly-1.1.0.xsd">
  <id>linux64</id>
  <formats>
    <format>tar.gz</format>
  </formats>
  <fileSets>
    <fileSet>
      <directory>../../distribution</directory>
      <outputDirectory>/</outputDirectory>
      <includes>
        <include>**</include>
      </includes>
    </fileSet>
  </fileSets>
  <dependencySets>
"""
    
    for row in reader:
        if row["classifier"]:
            include = "{}:{}:{}:{}".format(row["groupId"], row["artifactId"], row["extension"], row["classifier"])
        else:
            include = "{}:{}:{}".format(row["groupId"], row["artifactId"], row["extension"])

        txt = """
    <dependencySet>
      <outputDirectory>{}</outputDirectory>
      <useProjectArtifact>false</useProjectArtifact>
      <includes>
        <include>{}</include>
      </includes>
      <outputFileNameMapping>{}-${{artifact.version}}${{dashClassifier?}}.${{artifact.extension}}</outputFileNameMapping>
    </dependencySet>"""
        print txt.format(row["filename"], include, row["filename"])
        

    print """
  </dependencySets>
</assembly>
"""
