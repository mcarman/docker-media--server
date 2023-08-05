FROM alpine:latest

ARG BUILD_DATE

LABEL Maintainer="Peter Winter <peter@pwntr.com>"
LABEL org.label-schema.myname="samba on alpine w/"
LABEL org.label-schema.ver sion="1.0.2"
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL org.label-schema.description="Simple and lightweight container based on P Winter samba. Added tini to eliminate reavers causing samba halt. Modified for personal use"
# upgrade base system and install samba and supervisord
RUN apk --no-cache upgrade && \
    apk --no-cache add samba \
    samba-common-tools \
    supervisor \
    tini &&\
    rm -rf /tmp/* /var/tmp/* && \
    # create a dir for the config an d the share
    mkdir /config /shares && \
    addgroup -g 995 $SAMBA_GROUP && \
    adduser -D -H -G $SAMBA_GROUP -s /bin/false -u 1000 $SAMBA_USER && \
    adduser -D -H -G $SAMBA_GROUP -s /bin/false -u 1010 mdc1 && \
    adduser -D -H -G $SAMBA_GROUP -s /bin/false -u 1020 bac

# volume mappings
VOLUME /shares /config

COPY *.conf /config/
# copy config files from project folder to get a default config going for 
# samba and supervisord

RUN echo -e "$SAMBA_PASSWD\n$SAMBA_PASSWD" | smbpasswd -a -s -c /config/smb.conf $SAMBA_USER
# add a non-root user and adduser -M -u 1000 -g 995 newusrgroup called "pims:docker" 
# with no password, no home dir, no shell, and gid/uid set to 1000
# create a samba user matching our user from above with a very simple password

# exposes samba's default ports (135 for End Point Mapper 
# [DCE/RPC Locator Service],137, 138 for nmbd and 139, 445 for smbd)
# this setup will not use nmb. Will use wsdd2 if possible
EXPOSE 445

# Add tini to stop the unreaved signals
ENTRYPOINT ["tini", "-s", "supervisord", "-c", "/config/supervisord.conf"]
# ["bin/sh", "supervisord", "-c", "/config/supervisord.conf"]
CMD []
