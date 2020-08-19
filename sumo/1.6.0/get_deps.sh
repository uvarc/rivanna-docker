#!/bin/bash
OUT="copy"
IMAGE=2a2e

if [ -e $OUT ]; then
    rm $OUT
fi

function docker_run {
    docker run --rm -it --entrypoint=bash $IMAGE -c "$1" >>$OUT
}

docker_run "dpkg -L sumo"
docker_run "ldd /opt/sumo-1.6.0/bin/*"
