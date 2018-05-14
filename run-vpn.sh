#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
mkdir -p $DIR/vpn-certs

if [ -f $DIR/vpn-certs/clients ]; then
    echo "Clients file persist"
else 
    cp $DIR/clients /$DIR/vpn-certs/clients.secrets
fi

echo "Stopping container, please waiting a while"
docker container stop vpn-ike2
echo "Removing container"
docker container rm vpn-ike2
echo "Build and run new container"
docker build -t vpn-ike2 .
docker container run -v $DIR/vpn-certs:/vpn-certs --privileged -p 500:500/udp -p 4500:4500/udp --name vpn-ike2 -d vpn-ike2
