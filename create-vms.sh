#!/bin/sh

set -e
CONSULPORT=8500
SLAVEPORT=2376
MASTERPORT=3376

# Keystore
(
	NODENAME=ks
	docker-machine create -d virtualbox \
	    --engine-label "eu.hbp.name=$NODENAME" \
	    --engine-label "eu.hbp.function=keystore" \
	    $NODENAME
	eval $(docker-machine env keystore)
	docker run --restart=unless-stopped -d -p $CONSULPORT:$CONSULPORT -h consul progrium/consul -server -bootstrap
	curl $(docker-machine ip keystore):$CONSULPORT/v1/catalog/nodes
)

# Manager HA
for NODENAME in m0 m1
do
    (
	docker-machine create -d virtualbox \
	    --engine-label "eu.hbp.name=$NODENAME" \
	    --engine-label "eu.hbp.function=manager" \
	    --engine-opt="cluster-store=consul://$(docker-machine ip keystore):$CONSULPORT" \
	    --engine-opt="cluster-advertise=eth1:$MASTERPORT" $NODENAME
	eval $(docker-machine env $NODENAME)
	docker run --restart=unless-stopped -d -p $MASTERPORT:$MASTERPORT \
		-v /var/lib/boot2docker:/certs:ro \
		swarm manage -H 0.0.0.0:$MASTERPORT \
		--tlsverify \
		--tlscacert=/certs/ca.pem \
		--tlscert=/certs/server.pem \
		--tlskey=/certs/server-key.pem \
		--replication --advertise $(docker-machine ip $NODENAME):$MASTERPORT \
		consul://$(docker-machine ip keystore):$CONSULPORT
    )
done

# Slaves
for NODENAME in n0 n1 n2
do
    (
	docker-machine create -d virtualbox \
	    --engine-label "eu.hbp.name=$NODENAME" \
	    --engine-label "eu.hbp.function=worker" \
	    --engine-opt="cluster-store=consul://$(docker-machine ip keystore):$CONSULPORT" \
	    --engine-opt="cluster-advertise=eth1:$SLAVEPORT" $NODENAME
	eval $(docker-machine env $NODENAME)
	docker run -d swarm join --addr=$(docker-machine ip $NODENAME):$SLAVEPORT \
	    consul://$(docker-machine ip keystore):$CONSULPORT
	docker-machine scp -r raw-admin $NODENAME:
	docker-machine scp -r data $NODENAME:
    )
done
