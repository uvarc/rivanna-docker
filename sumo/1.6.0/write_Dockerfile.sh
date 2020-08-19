#!/bin/bash
IN=sorted
OUT=Dockerfile

cp Dockerfile.build $OUT

cat >>$OUT <<EOF

FROM gcr.io/distroless/cc-debian10
COPY --from=build /opt/sumo-1.6.0/bin /opt/sumo-1.6.0/bin
EOF


echo "COPY --from=build \\" >>$OUT
DIR_PREV=$(dirname `head -1 $IN`)

while read -r line; do
    DIR=`dirname $line`

    if [ ! "$DIR" = "$DIR_PREV" ]; then
        echo "        $DIR_PREV/"
        echo "COPY --from=build \\"
    fi
    echo "        $line \\"

    DIR_PREV=$DIR
done <$IN >>$OUT

echo "        $DIR_PREV/" >>$OUT

cat >>$OUT <<EOF

ENV PATH=/opt/sumo-1.6.0/bin:\$PATH
LABEL maintainer=rs7wz@virginia.edu

ENTRYPOINT ["sumo"]
EOF
