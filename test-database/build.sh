#!/bin/bash
#
# build.sh

CURRENTVERSION=$(cat ./build.version)
NEXTVERSION=$(($CURRENTVERSION+1))
printf "Current version: ${CURRENTVERSION}\n"
printf "Next version: ${NEXTVERSION}\n"

docker build --rm -t  sample-db-v${NEXTVERSION} .
if [ $? -ne 0 ]; then
	printf "Failed to build new version ($NEXTVERSION)\n"
	exit 1
else
	printf "Successfully built new version ($NEXTVERSION)\n"
	echo ${NEXTVERSION} > ./build.version
	exit $?
fi
