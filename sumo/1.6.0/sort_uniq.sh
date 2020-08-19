#!/bin/bash
IN=copy
OUT=sorted

awk '{
    if (NF==2) print $1
    else if (NF==4) print $3
}' $IN | sort | uniq >$OUT
