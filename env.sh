#!/bin/sh
#                    Copyright (c) 2016-2016
#   Data Intensive Applications and Systems Labaratory (DIAS)
#            Ecole Polytechnique Federale de Lausanne
#
#                      All Rights Reserved.
#
# Permission to use, copy, modify and distribute this software and its
# documentation is hereby granted, provided that both the copyright notice
# and this permission notice appear in all copies of the software, derivative
# works or modified versions, and any portions thereof, and that both notices
# appear in supporting documentation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. THE AUTHORS AND ECOLE POLYTECHNIQUE FEDERALE DE LAUSANNE
# DISCLAIM ANY LIABILITY OF ANY KIND FOR ANY DAMAGES WHATSOEVER RESULTING FROM THE
# USE OF THIS SOFTWARE.

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
