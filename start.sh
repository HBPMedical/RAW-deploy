#!/bin/sh

function usage() {
cat <<EOT
usage: $0 [-h|--help] (single|swarm target-node) <docker-compose command>
	-h, --help: show this message and exit
	single:	deploy on the local machine
	swarm:	deploy on the node 'target-node' of the swarm cluster.
		docker-compose uses the environment to contact the appropriate
		docker daemon, so it must be correctly set.
	<docker-compose command>: This is forwarded as is to docker-compose

The following environment variables can be set to override defaults:
 - raw_data_root	Folder containing the data
 - raw_admin_root	Folder containing the administration configuration

Errors: This script will exit with the following error codes:
 1	No arguments provided
 2	First arguments is incorrect
 3	Missing arguments for Swarm invocation
EOT
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

. ./env.sh

case $1 in
    -h|--help)
	usage
	exit 0
	;;

    [sS][wW][aA][rR][mM])
	shift
	if [ $# -lt 2 ]; then
		usage
		exit 3
	fi
	(
		export swarm_node=$1
		shift
		sed -e "s,SWARMNODE,${swarm_node},g" docker-compose-swarm.yml > docker-compose-node-${swarm_node}.yml
		# If the node-only network doesn't exists, create it.
		docker network ls | grep -q ${swarm_node}/mip_net-local || \
			docker network create -d bridge ${swarm_node}/mip_net-local
		docker-compose -f "docker-compose-node-${swarm_node}.yml" $@
	)
	;;

    single)
	shift
	docker-compose -f docker-compose-single.yml $@
	;;

    *)
	usage
	exit 2
	;;
esac
