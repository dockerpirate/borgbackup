# Main stage.
FROM arm32v7/alpine as main

ENV USER=borg
ENV UID=1000
ENV GID=23456

LABEL maintainer="Riadh Habbachi<habbachi.riadh@gmail.com>" \
      version="1.1.3" \
      description="Borgbackup docker image based on alpine. Deduplicating \
      archiver with compression and authenticated encryption."

# Install Borg & SSH.
RUN apk add --no-cache \
        borgbackup \
        openssh \
        sshfs \
        supervisor \

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$USER" \
    --shell /bin/sh \
    --uid "$UID" \
    "$USER" \
    ssh-keygen -A && \
    mkdir /backups && \
    chown borg:borg /backups && \
    sed -i \
        -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        -e 's/^PermitRootLogin without-password$/PermitRootLogin no/g' \
        /etc/ssh/sshd_config

RUN passwd -u borg

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22

CMD ["/usr/bin/supervisord"]
