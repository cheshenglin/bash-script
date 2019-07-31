#!/bin/bash
HOST="localhost"
USER="root"
PASSWORD=""
PREFIX="mysql"

if [ "$1" != "" ]; then
    WORKING_DIR=$1
else
    WORKING_DIR=$(pwd)
fi

databases=$(mysql -h $HOST -u $USER -p$PASSWORD -e 'show databases;' 2> /dev/null | awk '{print $1}' | tail -n +2)
for dbname in $databases; do
    if [[ $dbname != "$PREFIX"* ]] ; then continue ; fi
    $(mysqldump -h $HOST -u $USER -p$PASSWORD --databases $dbname > ${WORKING_DIR}${dbname}_`date +%Y%m%d`.sql 2> /dev/null)
done
