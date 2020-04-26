FROM alpine
WORKDIR /root

# Install cron
RUN apk update && apk add dcron curl wget rsync ca-certificates && rm -rf /var/cache/apk/*
RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d
COPY /scripts/* /
COPY crontab /etc/cron.d

# Install RCON-CLI
RUN apk add git openssh-client
RUN wget https://github.com/itzg/rcon-cli/releases/download/1.4.7/rcon-cli_1.4.7_linux_386.tar.gz
RUN tar -xf rcon-cli_1.4.7_linux_386.tar.gz

COPY ./ssh_config /root/.ssh/config

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]