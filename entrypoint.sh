#!/bin/bash
set -e

POSTFIX_DATA_DIR=${DATA_DIR}/etc
POSTFIX_LOGS=${DATA_DIR}/logs
POSTFIX_SPOOL=${DATA_DIR}/spool

create_postfix_data_dir() {
  mkdir -p ${POSTFIX_DATA_DIR}

  # populate default bind configuration if it does not exist
  if [ ! -d ${POSTFIX_DATA_DIR}/etc ]; then
    mv /etc/postfix ${POSTFIX_DATA_DIR}/etc
  fi
  rm -rf /etc/postfix
  ln -sf ${POSTFIX_DATA_DIR}/etc /etc/postfix
  chmod -R 0775 ${POSTFIX_DATA_DIR}
}

create_postfix_data_dir

/etc/init.d/postfix start
