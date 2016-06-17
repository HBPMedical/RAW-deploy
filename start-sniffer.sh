#!/bin/sh

# Make sure the required dirctories are there
test -d ${docker_data_folder} || exit 1

# Start the container
docker run -d \
    --net=${docker_network} \
    --name RawSniffer \
    --net-alias=raw-sniffer \
    -v ${docker_data_folder}:${container_data_folder}:ro \
    sambuc/hbp-raw-sniffer
