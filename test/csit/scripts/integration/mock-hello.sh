#!/bin/bash -v
# $1 ip address of the mock server

curl -v -X PUT -d @- http://$1:1080/expectation <<EOF
{
    "httpRequest": {
        "method": "GET",
        "path": "/hello"
    },
    "httpResponse": {
        "body": "Hello world!",
        "statusCode": 200
    }
}
EOF

