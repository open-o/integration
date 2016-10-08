#!/bin/bash -v
cd ./nfvo/lcm
# bypassing run.sh since it fails silently
# ./run.sh
python manage.py runserver `hostname -i`:8403
