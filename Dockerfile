FROM ubuntu

MAINTAINER info@uniq-it-4u.co.nz

ENV DATA_DIR=/data

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install postfix rsyslog

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 25/tcp

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/bin/bash"]
