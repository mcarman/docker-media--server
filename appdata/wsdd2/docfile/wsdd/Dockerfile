FROM debian:bullseye-slim AS builder
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y make tini
#  gcc \
#  musl-dev 
#  linux-headers-generic
COPY * /root/
RUN cd /root/ && make && find /root 

FROM debian:bookworm-slim  

ARG BUILD_DATE


LABEL Maintainer="mdcbldr, email"
LABEL org.label-schema.myname="wsdd on debian"
LABEL org.label-schema.version="1.0"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.description="This is a docker container for running wsdd, windows network discovery"

WORKDIR /root/
RUN systemctl enable wsdd.service &&\
    systemctl start wsdd.service
ENTRYPOINT /usr/sbin/wsdd2 -N $HOSTNAME -G ${WORKGROUP:-WORKGROUP}