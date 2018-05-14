#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
mkdir -p $DIR/vpn-certs
docker container run -v $DIR/vpn-certs:/vpn-certs --privileged -p 500:500/udp -p 4500:4500/udp --name vpn-ike2 -d vpn-ike2
