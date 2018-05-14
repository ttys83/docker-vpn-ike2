FROM debian:stretch-slim

COPY ./opt/* /opt/

RUN apt-get -yqq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yqq install -y --no-install-recommends \
	dnsutils \
	procps \
	nano \
	kmod \
	iptables \
	strongswan \
	strongswan-swanctl \
	strongswan-pki \
	libcharon-extra-plugins \
	libstrongswan-standard-plugins \
	moreutils \
    && rm -rf /var/lib/apt/lists/*

CMD ["/opt/run.sh"]

EXPOSE 500/udp 4500/udp
