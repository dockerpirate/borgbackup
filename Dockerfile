# Main stage.
FROM arm32v7/alpine as main

ENV USER=borg
ENV UID=1000
ENV GID=23456
ENV GROUP=backup

LABEL maintainer="dockerpirate" \
      version="1.1.10" \
      description="Borgbackup docker image based on alpine. Deduplicating \
      archiver with compression and authenticated encryption."

COPY borg_auto /etc/periodic/hourly

# Install Borg & SSH.
RUN apk add --no-cache \
        borgbackup \
        openssh \
        sshfs \
        supervisor \
        openrc

RUN addgroup -g "$GID" "$GROUP" && \
    adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$GROUP" \
    --shell /bin/sh \
    --uid "$UID" "$USER" && \
    ssh-keygen -A && \
    mkdir /backups && \
    chown "$USER":"$GROUP" /backups && \
    sed -i \
        -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        -e 's/^PermitRootLogin without-password$/PermitRootLogin no/g' \
        /etc/ssh/sshd_config

RUN passwd -u borg && \
      chmod +x /etc/periodic/hourly/borg_auto

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 22

CMD ["/usr/bin/supervisord"]
