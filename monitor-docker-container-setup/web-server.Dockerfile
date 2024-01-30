FROM httpd:latest AS apache-server-build-stage

WORKDIR /

RUN apt-get update -yq

RUN apt-get install tzdata -yq
ENV TZ="Asia/Singapore"

# Configure Timezone in the container
RUN ls /usr/share/zoneinfo && \
cp /usr/share/zoneinfo/Singapore /etc/localtime && \
echo "Asia/Singapore" > /etc/timezone 

RUN apt-get install systemd nano curl wget openssl libssl-dev iputils-ping openssh-server gcc libc6 libgd-dev  make autoconf -yq


FROM apache-server-build-stage AS nagios-plugin-installation-stage



# Setup Nagios Plugin 
RUN wget --inet4-only --content-disposition 'https://github.com/nagios-plugins/nagios-plugins/archive/refs/tags/2.4.8.tar.gz' -O nagios-plugins-2.4.8.tar.gz

RUN tar -xzvf nagios-plugins-2.4.8.tar.gz
RUN rm nagios-plugins-2.4.8.tar.gz


WORKDIR /nagios-plugins-2.4.8

RUN ./tools/setup

RUN ./configure

RUN make

RUN make install



FROM nagios-plugin-installation-stage AS setup-container-stage

WORKDIR /

COPY sshd_config /etc/ssh/sshd_config.d

RUN useradd nagios -m -U 

# https://stackoverflow.com/questions/2150882/how-to-automatically-add-user-account-and-password-with-a-bash-script
RUN echo nagios:password | chpasswd



CMD ["apachectl", "-D", "FOREGROUND"]