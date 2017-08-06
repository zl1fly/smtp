FROM ubuntu

MAINTAINER info@uniq-it-4u.co.nz

ENV DATA_DIR=/data

WORKDIR /

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install postfix rsyslog && \
    rm /var/lib/apt/lists/*lz4 && \
    apt-get -o Acquire::GzipIndexes=false update && \
    apt-get -y install wget perl libnet-ssleay-perl openssl libauthen-pam-perl \ 
                       libpam-runtime libio-pty-perl python apt-show-versions && \
    wget -q -O /webmin.deb http://www.webmin.com/download/deb/webmin-current.deb && \
    dpkg -i /webmin.deb
    
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

RUN echo "root:password" | chpasswd

EXPOSE 25/tcp
EXPOSE 10000/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]
