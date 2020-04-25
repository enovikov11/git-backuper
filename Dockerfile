FROM alpine
WORKDIR /root
RUN apk add git openssh-client

RUN wget https://github.com/itzg/rcon-cli/releases/download/1.4.7/rcon-cli_1.4.7_linux_386.tar.gz
RUN tar -xf rcon-cli_1.4.7_linux_386.tar.gz

COPY ./backup.sh /root/backup.sh
RUN chmod +x /root/backup.sh

COPY ./run.sh /root/run.sh
RUN chmod +x /root/run.sh

CMD /bin/sh /root/run.sh