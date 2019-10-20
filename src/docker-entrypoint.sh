#!/bin/bash
set -e

while ! (echo > /dev/tcp/${PARKINGAPI_DATABASE_HOST}/${PARKINGAPI_DATABASE_PORT}) > /dev/null
do
    let elapsed=elapsed+1
    if [ "$elapsed" -gt 15 ] 
    then
        echo "Time Out!"
        exit 1
    fi  
    sleep 1;
    echo "retrying postgres connection"
done

rails db:migrate

echo "Starting..."

exec "$@"
