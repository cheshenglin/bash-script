#!/bin/bash
OFFSET=3
CRITERIA=$(date -d "-$OFFSET days" +%G%m%d)

if [ "$1" != "" ]; then
    WORKING_DIR=$1
else
    WORKING_DIR=$(pwd)
fi

count=$(ls -1q $WORKING_DIR/*.tar.gz 2> /dev/null | wc -l)
printf "count = "$count"\n"
if (( $count==0 )); then
    exit
fi

for fullname in "$WORKING_DIR"/*.tar.gz; do
    barename=$(basename $fullname)
    barename=$(echo $barename | grep -o "^[0-9]*")
    if [[ $(($CRITERIA)) -ge $(($barename)) ]]; then
         rm $fullname
    fi
done
