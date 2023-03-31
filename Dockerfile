FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y git build-essential autoconf automake libtool pkg-config

RUN git clone --depth=1 https://github.com/troglobit/mcjoin.git /root/mcjoin
WORKDIR /root/mcjoin

RUN ./autogen.sh
RUN ./configure --prefix=/usr
RUN make

FROM ubuntu:20.04

COPY --from=0 /root/mcjoin/src/mcjoin /usr/bin/mcjoin

RUN apt-get update && \
    apt-get install -y net-tools iproute2 netcat dnsutils curl iputils-ping iptables nmap tcpdump iperf3 && \
    rm -rf /var/lib/apt/lists/*
