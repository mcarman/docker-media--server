FROM debian:bookworm AS builder

RUN apt-get install -y \
    samba \
    wsdd2 \
    samba-common \
    cifs-utils

RUN mkdir sambawsdd2

WORKDIR sambawsdd2

RUN cp /usr/sbin/*.*  


FROM debian:bookworm-slim
# set version label
ARG BUILD_DATE="30Jun2023"
ARG VERSION="Version 4.0"
ARG WSDD_VERSION = "2.0"
LABEL build_version="${VERSION} ${BUILD_DATE} "
LABEL maintainer="mdcbldr"

RUN addgroup -g 995 docker && \
    adduser -D -H -G docker -s /bin/false -u 1000 pims && \


COPY --from=0 /usr/sbin/ .
COPY --from=0 /etc/init.d/wsdd .
RUN apt-get install tini -y --no-install-recommends
RUN systemctl enable wsdd2.service && \
    systemctl start wsdd2.service
RUN systemctl enable smbd.service && \
    systemctl start smbd.service

RUN addgroup -g 1000 pims && \
    adduser -D -H -G pims -s /bin/false -u 1000 pims && \
    addgroup -g 995 docker 

RUN mkdir /shared /etc/samba/
VOLUME /shared /config

EXPOSE 445 3702 5355

ENTRYPOINT /usr/sbin/wsdd2 -N $HOSTNAME -G ${WORKGROUP:-WORKGROUP}

# if system supports apt
# wget -O- https://pkg.ltec.ch/public/conf/ltec-ag.gpg.key | gpg --dearmour > /usr/share/keyrings/wsdd.gpg
# source /etc/os-release
# echo "deb [signed-by=/usr/share/keyrings/wsdd.gpg] https://pkg.ltec.ch/public/ ${UBUNTU_CODENAME:-${VERSION_CODENAME:-UNKNOWN}} main" > /etc/apt/sources.list.d/wsdd.lis