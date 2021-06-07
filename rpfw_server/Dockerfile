FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

COPY ./sources.list /etc/apt/sources.list
RUN apt-get -y update && \
    apt-get -y install systemd iproute2 iputils-ping findutils && \
    apt-get -y -t buster-backports install "openssh-server" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./ssh_host_ecdsa_key /etc/ssh/
RUN chmod 600 /etc/ssh/ssh_host_ecdsa_key
COPY ./ssh_host_ecdsa_key.pub /etc/ssh/
RUN chmod 644 /etc/ssh/ssh_host_ecdsa_key.pub
COPY ./ssh_host_ed25519_key /etc/ssh/
RUN  chmod 600 /etc/ssh/ssh_host_ed25519_key
COPY ./ssh_host_ed25519_key.pub /etc/ssh/
RUN chmod 644 /etc/ssh/ssh_host_ed25519_key.pub
COPY ./ssh_host_rsa_key /etc/ssh/
RUN  chmod 600 /etc/ssh/ssh_host_rsa_key
COPY ./ssh_host_rsa_key.pub /etc/ssh/
RUN chmod 644 /etc/ssh/ssh_host_rsa_key.pub

RUN useradd -s /usr/sbin/nologin -m -d /home/rpfw rpfw
RUN mkdir /home/rpfw/.ssh
RUN chown rpfw /home/rpfw/.ssh
RUN chgrp rpfw /home/rpfw/.ssh
COPY ./authorized_keys /home/rpfw/.ssh
RUN chown rpfw /home/rpfw/.ssh/authorized_keys
RUN chgrp rpfw /home/rpfw/.ssh/authorized_keys
run chmod 600 /home/rpfw/.ssh/authorized_keys

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
