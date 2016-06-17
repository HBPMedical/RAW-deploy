#!/bin/sh

docker run -d \
    --net=${docker_network} \
    --name RawAdvisor \
    --net-alias=raw-cadvisor \
    --volume=/:/rootfs:ro \
    --volume=/var/run:/var/run:rw \
    --volume=/sys:/sys:ro \
    --volume=/var/lib/docker/:/var/lib/docker:ro \
    google/cadvisor:latest
