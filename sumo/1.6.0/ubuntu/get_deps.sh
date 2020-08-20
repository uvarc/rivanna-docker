#!/bin/bash
OUT="copy"
IMAGE=f8b7

if [ -e $OUT ]; then
    rm $OUT
fi

function docker_run {
    docker run --rm -it --entrypoint=bash $IMAGE -c "$1" >>$OUT
}

docker_run "dpkg -L sumo"
docker_run "ldd /usr/bin/activitygen /usr/bin/dfrouter /usr/bin/duarouter /usr/bin/jtrrouter /usr/bin/marouter /usr/bin/netconvert /usr/bin/netedit /usr/bin/netgenerate /usr/bin/od2trips /usr/bin/polyconvert /usr/bin/sumo /usr/bin/sumo-gui"
