#!/bin/bash -v

# Initialize DB schema
#./bin/initDB.sh root rootpass 3306 127.0.0.1

# Install python requirements
cd ./multivimbroker
./initialize.sh
