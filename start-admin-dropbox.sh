#!/bin/sh

# Make sure the required dirctories are there
(test -n "${raw_admin_log}" && test -e ${raw_admin_log}) || (
	mkdir ${raw_admin_log}
)

test -d ${raw_admin_log} || exit 1
test -d ${raw_admin_static} || exit 2
test -d ${raw_admin_conf} || exit 3

chmod 777 ${raw_admin_log}
chmod 666 ${raw_admin_log}/*.log

# Start the container
docker run -d -p 80:80 \
    --net=${docker_network} \
    --name RawAdmin \
    --net-alias=raw-admin \
    -v ${raw_admin_static}:/usr/share/nginx/html:ro \
    -v ${raw_admin_conf}/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v ${raw_admin_log}:/var/log/nginx:rw \
    sambuc/hbp-raw-admin
