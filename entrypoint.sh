#!/bin/bash
set -e

POSTFIX_DATA_DIR=${DATA_DIR}/etc
POSTFIX_LOGS=${DATA_DIR}/logs
POSTFIX_SPOOL=${DATA_DIR}/spool
WEBMIN_DATA=${DATA_DIR}/webmin

create_postfix_data_dir() {
  mkdir -p ${DATA_DIR}

  # populate default postfix configuration if it does not exist
  if [ ! -d ${POSTFIX_DATA_DIR} ]; then
    mkdir -p ${POSTFIX_DATA_DIR}
    cd /etc/postfix
    tar cf - . | (cd ${POSTFIX_DATA_DIR}; tar xf - ) 
    #mv /etc/postfix ${POSTFIX_DATA_DIR}
  fi
  cd / 
  rm -rf /etc/postfix
  ln -sf ${POSTFIX_DATA_DIR} /etc/postfix
  #chmod -R 0775 ${POSTFIX_DATA_DIR}
}

create_postfix_spool_dir() {

  # populate postfix spool if it does not exist
  if [ ! -d ${POSTFIX_SPOOL} ]; then
    mkdir -p ${POSTFIX_SPOOL}
    cd /var/spool/postfix
    tar cf - . | (cd ${POSTFIX_SPOOL}; tar xf - )
  fi
  cd /
  rm -rf /var/spool/postfix
  ln -sf ${POSTFIX_SPOOL} /var/spool/postfix
}


create_postfix_log_dir() {

  # populate postfix logs if it does not exist
  if [ ! -d ${POSTFIX_LOGS} ]; then
    mkdir -p ${POSTFIX_LOGS}
    cd /var/log
    tar cf - . | (cd ${POSTFIX_LOGS}; tar xf - )
  fi
  cd /
  rm -rf /var/log
  ln -sf ${POSTFIX_LOGS} /var/log
}

create_webmin_dir() {

  # populate postfix logs if it does not exist
  if [ ! -d ${WEBMIN_DATA} ]; then
    mkdir -p ${WEBMIN_DATA}
    cd /etc/webmin
    tar cf - . | (cd ${WEBMIN_DATA}; tar xf - )
  fi
  cd /
  rm -rf /etc/webmin
  ln -sf ${WEBMIN_DATA} /etc/webmin
}


create_postfix_data_dir
create_postfix_spool_dir
create_postfix_log_dir
create_webmin_dir

/etc/init.d/webmin start
/etc/init.d/rsyslog start
/etc/init.d/postfix start

#/bin/bash

tail -f /var/log/mail.log
