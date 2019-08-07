#!/bin/bash
HOST="localhost"
USER="root"
PASSWORD=""
MYSQL_DIR=""
PREFIX="mysql"

if [ "$1" != "" ]; then working_dir=$1
else working_dir=$(pwd); fi
if [[ $working_dir != *"/" ]] ; then working_dir=$working_dir"/" ; fi

credential="-h $HOST -u $USER -p'${PASSWORD}'";
databases=$(${MYSQL_DIR}mysql ${credential} -e 'show databases;' 2> /dev/null | awk '{print $1}' | tail -n +2)
for dbname in $databases; do
    if [[ $dbname != "$PREFIX"* ]] ; then continue ; fi
    $(${MYSQL_DIR}mysqldump ${credential} --databases $dbname > ${working_dir}${dbname}_`date +%Y%m%d`.sql 2> /dev/null)
done
