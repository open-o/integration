#!/bin/bash -v
cd ./nfvo/drivers/vnfm/svnfm/zte/vmanager
# bypassing run.sh since it fails silently
# ./run.sh
python manage.py runserver `hostname -i`:8410

