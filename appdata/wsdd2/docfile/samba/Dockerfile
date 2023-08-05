FROM alpine:latest

ARG SAMBA_USER=$SAMBA_USER
ARG SAMBA_USER2=$SAMBA_USER2
ARG SAMBA_USER#=$SANBA_USER3
ARG SAMBA_PASSWD=$SAMBA_PASSWD
ARG PUID=$PUID
ARG PGID=$PGID

LABEL Maintainer="Peter Winter <peter@pwntr.com>"
LABEL org.label-schema.myname="samba on alpine w/"
LABEL org.label-schema.version="1.0.2"
LABEL org.label-schema.build-date="10Jun2023"
LABEL org.label-schema.description="Simple and lightweight Samba docker container, based on Alpine Linux."
# upgrade base system and install samba and supervisord
RUN apk --no-cache upgrade && \
    apk --no-cache add samba \
    samba-common-tools\
    bash \
    doas \
    supervisor \
    tini && \
    rm -rf /tmp/*

# add users. added in two steps to avoid the dialog  for password entry
RUN addgroup -g $PGID $SAMBA_GROUP; \
    adduser -D -H -G $SAMBA_GROUP -s /bin/false -u $PUID $SAMBA_USER; \
    echo -e "$SAMBA_USER\n$SAMBA_PASSWD" | smbpasswd -a -s -c; \
    adduser -e -D -H -G $SAMBA_GROUP -s /bin/false $SAMBA_USER2; \ 
    echo "$SAMBA_USER2\n$SAMBA_PASSWD" | smbpasswd -a -s -c; \ 
    adduser -e -D -H -G $SAMBA_GROUP -s /bin/false $SAMBA_USER3; \ 
    echo "$SAMBA_USER3\n$SAMBA_PASSWD" | smbpasswd -a -s -c; \
    echo "permit nopass :$SAMBA_GROUP as root" > /etc/doas.d/doas.conf 

# create a dir for the config and the share
RUN mkdir -p /config/etc /shares/media /shares/mdc1; \
    chmod 2775 /config && chown -R $SAMBA_USER:$SAMBA_GROUP /config; \
    chmod 2775 /shares && chown -R $SAMBA_USER:&SAMBA_GROUP /shares   

# copy config files from project folder to get a default config going for samba and supervisord
WORKDIR /config
COPY *.sh /config
     
# create a samba user matching our user from above with a very simple password

# dd to the system for start on boot  did not work
# RUN  rc-update add samba

# volume mappings
VOLUME /config /shares

# exposes samba's default ports (135 for End Point Mapper [DCE/RPC Locator Service],
# 137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 445

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
