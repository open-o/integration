#!/bin/sh

# autorelease root dir
ROOT=`git rev-parse --show-toplevel`/autorelease

BUILD_DIR=$ROOT/build

mkdir -p $BUILD_DIR
cd $BUILD_DIR

FILE=$BUILD_DIR/pom.xml

cat > $FILE <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.openo</groupId>
  <artifactId>openo</artifactId>
  <version>1.0.0-SNAPSHOT</version>
  <packaging>pom</packaging>
  <modules>
EOF

while read p; do
    cat >> $FILE <<EOF
    <module>$p</module>
EOF
done < $ROOT/java-projects.txt

cat >> $FILE <<EOF
  </modules>
</project>
EOF
