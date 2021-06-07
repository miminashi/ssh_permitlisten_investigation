FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

#COPY ./sources.list /etc/apt/sources.list
#RUN apt-get -y update && \
#    apt-get -y install systemd iproute2 iputils-ping && \
#    apt-get -y -t buster-backports install "openssh-server" && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*
RUN apt-get -y update && \
    apt-get -y install systemd iproute2 iputils-ping openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash -m -d /home/pi pi
RUN mkdir /home/pi/.ssh
COPY ./id_ed25519_rpfw_client_2 /home/pi/.ssh/id_ed25519
COPY ./id_ed25519_rpfw_client_2.pub /home/pi/.ssh/id_ed25519.pub
RUN chown -R pi /home/pi/.ssh
RUN chgrp -R pi /home/pi/.ssh
RUN chmod 600 /home/pi/.ssh/id_ed25519

COPY ./rpfw.sh /usr/local/sbin/rpfw
RUN chmod +x /usr/local/sbin/rpfw

COPY ./ssh_known_hosts /etc/ssh/ssh_known_hosts
COPY ./ssh-rpfw.service /etc/systemd/system/
RUN systemctl enable ssh-rpfw.service

STOPSIGNAL SIGRTMIN+3
CMD [ "/sbin/init" ]
