#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${USER_ID:-1000}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user

chown -R user:user /home/user
IFS=':'; DIRLIST=($USER_DIRS); unset IFS;
numDIR=${#DIRLIST[@]}

for ((i=0;i<numDIR;i++));do
    dir=${DIRLIST[$i]}
    if [ -d "$dir" ];then
        chown -R user:user $dir
    else
        echo "$dir does not exist"
    fi
done
exec /usr/local/bin/gosu user "$@"

