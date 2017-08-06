FROM ubuntu


MAINTAINER Robert robert@uniq-it-4u.co.nz

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install postfix webmin 

ENTRYPOINT ["/bin/bash"]

