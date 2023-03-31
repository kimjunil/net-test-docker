FROM alpine:3.12
RUN apk add --update git build-base automake autoconf

RUN git clone --depth=1 https://github.com/troglobit/mcjoin.git /root/mcjoin
WORKDIR /root/mcjoin

RUN ./autogen.sh
RUN ./configure --prefix=/usr
RUN make

FROM alpine:3.12

COPY --from=0 /root/mcjoin/src/mcjoin /usr/bin/mcjoin

RUN apk update && \
    apk add net-tools iproute2 netcat-openbsd bind-tools curl iputils iptables nmap tcpdump iperf3 
