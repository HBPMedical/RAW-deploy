#!/bin/sh
export docker_network=mip-bundle
export docker_data_folder="${PWD}/data"
export container_data_folder="/datasets"
#export port_raw_engine=54321
#export port_raw_sniffer=5555

export raw_admin_static=${PWD}/raw-admin/static
export raw_admin_conf=${PWD}/raw-admin/conf
export raw_admin_log=${PWD}/raw-admin/logs

export docker_ip=$(ip addr | awk '/inet/ && /docker0/{sub(/\/.*$/,"",$2); print $2}')
