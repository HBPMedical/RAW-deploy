#!/bin/sh
# Node-specific config:
: ${raw_data_root:="${PWD}/data"}
: ${raw_admin_root:="${PWD}/raw-admin"}
export raw_data_root raw_admin_root

# Whole Swarm config
export COMPOSE_PROJECT_NAME="mip"
export docker_data_folder="/datasets"

export raw_admin_static=${raw_admin_root}/static
export raw_admin_conf=${raw_admin_root}/conf
export raw_admin_log=${raw_admin_root}/logs
