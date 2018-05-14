#!/bin/sh

# run: cert-gen.sh ip.ad.dr.es

BASEDIR="/vpn-certs"

mkdir -p $BASEDIR

if [ -z $1 ]; then
    echo "Please, specify the IP address. Exiting..."
    exit 1
else 
    SRVIP=$1
fi

if [ -f $BASEDIR/server-root-key.pem ]; then
    echo "Root key is already present"
else
    ipsec pki --gen --type rsa --size 4096 --outform pem > $BASEDIR/server-root-key.pem
fi

if [ -f $BASEDIR/server-root-ca.pem ]; then
    echo "Root CA is already present"
else
    ipsec pki --self --ca --lifetime 3650 \
	--in $BASEDIR/server-root-key.pem \
	--type rsa --dn "C=US, O=VPN Server, CN=VPN Server Root CA" \
	--outform pem > $BASEDIR/server-root-ca.pem
fi

if [ -f $BASEDIR/vpn-server-key.pem ]; then
    echo "VPN Server key is already present"
else
    ipsec pki --gen --type rsa --size 4096 --outform pem > $BASEDIR/vpn-server-key.pem
fi

if [ -f $BASEDIR/vpn-server-cert.pem ]; then
    echo "VPN Server cert is already present"
else
    ipsec pki --pub --in $BASEDIR/vpn-server-key.pem \
	--type rsa | ipsec pki --issue --lifetime 1825 \
	--cacert $BASEDIR/server-root-ca.pem \
	--cakey $BASEDIR/server-root-key.pem \
	--dn "C=US, O=VPN Server, CN=$SRVIP" \
	--san $SRVIP \
	--flag serverAuth --flag ikeIntermediate \
	--outform pem > $BASEDIR/vpn-server-cert.pem
fi

cp $BASEDIR/vpn-server-cert.pem /etc/ipsec.d/certs/vpn-server-cert.pem
cp $BASEDIR/vpn-server-key.pem /etc/ipsec.d/private/vpn-server-key.pem
chmod 600 /etc/ipsec.d/private/vpn-server-key.pem
