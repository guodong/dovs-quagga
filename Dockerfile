FROM snlab/dovs:latest
RUN apt update
RUN curl -O http://download-mirror.savannah.gnu.org/releases/quagga/quagga-1.2.4.tar.gz && tar zxvf ./quagga-1.2.4.tar.gz && cd quagga-1.2.4
RUN apt install -y gawk gcc
RUN apt install -y libreadline-dev pkg-config
RUN apt install -y libc-ares-dev
WORKDIR /quagga-1.2.4
RUN ./configure --enable-fpm --enable-user=root --enable-group=root --enable-vty-group=root && make && make install
RUN cp /usr/local/lib/lib* /lib/
RUN apt install -y vim telnet
RUN groupadd quagga && useradd quagga -g quagga && usermod -u 0 -o quagga
RUN mkdir /etc/quagga && cp /usr/local/etc/zebra.conf.sample /etc/quagga/zebra.conf && cp /usr/local/etc/ospfd.conf.sample /etc/quagga/ospfd.conf
RUN chown quagga:quagga /etc/quagga/* && chmod 640 /etc/quagga/*
