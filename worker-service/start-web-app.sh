#!/bin/bash
# script to start web app container
version=$1
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "usage: ./start-web-app.sh <version-number>"
    echo "example:./start-web-app.sh 1, for image sample-node-app--v1"
    exit 1
fi
docker run \
         --name=worker-app \
         -e DATABASE_HOST=192.168.99.100 \
         -e DATABASE_NAME=users \
         -e DATABASE_USER=users_service \
         -e DATABASE_PORT=3306 \
         -p 8123:8123 \
         -d sample-node-app-v${version}
