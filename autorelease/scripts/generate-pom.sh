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
  <groupId>org.openo.integration.distribution</groupId>
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
  <dependencies>
EOF

$ROOT/scripts/generate-binary-deps.py < $ROOT/binaries.csv >> $FILE

cat >> $FILE <<EOF
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <configuration>
          <appendAssemblyId>true</appendAssemblyId>
          <descriptors>
            <descriptor>assembly.xml</descriptor>
          </descriptors>
        </configuration>
        <executions>
          <execution>
            <id>make-assembly</id>
            <phase>package</phase>
            <goals>
              <goal>single</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

</project>
EOF
