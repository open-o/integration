#!/usr/bin/env python
#
# Copyright 2016-2017 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# pipe in binaries.csv from stdin

import sys, csv, subprocess

version = "1.1.0-SNAPSHOT"


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
