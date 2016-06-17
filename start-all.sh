#!/bin/sh
. ./env.sh
echo "Found docker host ip: ${docker_ip}"

# Create a virtual Network for the docker images
if docker network ls|grep -q ${docker_network}; then
	echo "Using private docker network: ${docker_network}"
else
	docker network create ${docker_network}
	echo "Created private docker network: ${docker_network}"
fi

services=
services="$services ./start-advisor.sh"
services="$services ./start-engine.sh"
services="$services ./start-sniffer.sh"
services="$services ./start-admin-basic.sh"
#services="$services ./start-admin-dropbox.sh"
docker kill RawAdmin RawEngine RawSniffer RawAdvisor
docker rm RawAdmin RawEngine RawSniffer RawAdvisor
for f in $services
do
    $f
done
