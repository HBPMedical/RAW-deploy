#!/bin/sh

machines="keystore m0 m1 n0 n1 n2"
docker-machine kill $machines
docker-machine rm $machines
