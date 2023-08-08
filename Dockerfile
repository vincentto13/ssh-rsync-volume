FROM alpine:latest
MAINTAINER Pawel Rapkiewicz <pawel.rapkiewicz@gmail.com>

ARG SSH_PORT=2022

RUN apk add --no-cache openssh rsync

RUN mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh \
    && apk add openrc openssh \
    && ssh-keygen -A \
    && echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE $SSH_PORT

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]
