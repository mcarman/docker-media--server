FROM alpine:latest

ARG PGID=${PGID:-1000}
ARG SAMBA_GROUP=${SAMBA_GROUP:-docker}
ARG SAMBA_USER=${SAMBA_USER:-sambauser}
ARG PUID=${PUID:-1000}
ARG SAMBA_PASSWD=${SAMBA_PASSWD:-samba}
ARG SAMBA_USER2=${SAMBA_USER2:-sambauser2}
ARG SAMBA_USER3=${SAMBA_USER3:-sambauser3}

LABEL Maintainer="Peter Winter <peter@pwntr.com>"
LABEL org.label-schema.myname="samba on alpine w/"
LABEL org.label-schema.version="1.0.2"
LABEL org.label-schema.build-date="10Jun2023"
LABEL org.label-schema.description="Simple and lightweight Samba docker container, based on Alpine Linux."
# upgrade base system and install samba, doas, bash, and tini
RUN apk --no-cache upgrade && \
    apk --no-cache add samba \
    samba-common-tools \
    bash \
    doas \
    tini && \
    rm -rf /tmp/*

#     mkdir /config /shares
RUN bash && exec /bin/bash && \
    mkdir -p /config && \
    mkdir -p /shares/media && \
    chmod 2777 /shares/media && \
    chmod 2775 /config 

    # add grouop, adduser and allow to run as root
RUN addgroup -g $PGID ${SAMBA_GROUP} && \
    adduser -H -D -u $PUID $SAMBA_USER -G $SAMBA_GROUP && \
    # set passwprd and let uer run as root; \
    echo "$SAMBA_USER:$SAMBA_PASSWD" | chpasswd && \
    echo "permit nopass :$SAMBA_GROUP as root" > /etc/doas.d/doas.conf && \
    smbpasswd -s -n -a $SAMBA_USER

# copy config files from project 
# folder to get a default config going for samba and supervisord
COPY . /config
# RUN  chmod +x entrypoint.sh

# volume mappings
VOLUME /config /shares

# exposes samba's default ports (135 for End Point Mapper [DCE/RPC Locator Service],
# 137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 445

ENTRYPOINT ["/sbin/tini", "--", "/config/./entrypoint.sh"]
# CMD ["/bin/bash"]