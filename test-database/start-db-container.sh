#!/bin/bash
# this script starts db ( mysql ) container
version=$1
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "usage: ./start-db-container.sh <version-number>"
    echo "example: ./start-db-container.sh 1, for image sample-db-v1"
    exit 1
fi
docker run --name db -d \
  -e MYSQL_ROOT_PASSWORD=123 \
  -e MYSQL_DATABASE=users -e MYSQL_USER=users_service -e MYSQL_PASSWORD=123 \
  -p 3306:3306 \
  sample-db-v${version}
