FROM ubuntu:bionic

# Based on the Dockerfile for Palakis/docker-icecast-kh by Stéphane Lepin <stephane.lepin@gmail.com>
MAINTAINER Roman Ermakov <r.ermakov@emg.fm>

ENV DEBIAN_FRONTEND noninteractive
ENV IC_VERSION "2.4.0-kh22"

RUN apt-get -y update && \
	apt-get -y install python3 python3-pip build-essential \
		wget curl libxml2-dev libxslt1-dev \
		libogg-dev libvorbis-dev libtheora-dev \
		libspeex-dev libssl-dev libcurl4-openssl-dev

RUN \
	wget "https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz" -O- | tar zxvf - && \
	cd "icecast-kh-icecast-$IC_VERSION" && \
	./configure --with-openssl=yes --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
	grep SSL config.h && \
	make && make install && useradd icecast && \
	chown -R icecast /etc/icecast.xml && \
	sed -i "s/<sources>[^<]*<\/sources>/<sources>42<\/sources>/g" /etc/icecast.xml

RUN pip3 install supervisor

ADD ./start.sh /start.sh
ADD ./etc /etc
ADD ./admin /usr/local/share/icecast/admin
ADD ./web /usr/local/share/icecast/web
ADD ./web/images /usr/local/share/icecast/web/images
ADD ./web/player /usr/local/share/icecast/web/player
ADD ./web/player/css /usr/local/share/icecast/web/player/css
ADD ./web/player/image /usr/local/share/icecast/web/player/image
ADD ./web/player/script /usr/local/share/icecast/web/player/script

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/config", "/var/log/icecast"]
