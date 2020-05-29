#!/bin/bash
README="README.md"
LIST="List of Docker images" 

TMP=$(mktemp)

function get_image_info {
    if [ $# -ne 1 ]; then
        echo "get_image_info app"
        exit 1
    fi
    curl -slSL https://hub.docker.com/v2/repositories/uvarc/$1/tags/ | tr ',' '\n' >$TMP
}

cat >$README <<EOF
# rivanna-docker

**Autogenerated - do not edit manually!**  
Run \`writeREADME.sh\` to update this \`README.md\`.

This repository contains Dockerfiles for Rivanna.

## Structure

<pre>
.
├── app1
│   ├── version1
│   │   ├── Dockerfile
│   │   └── README.md
│   └── version2
│       ├── Dockerfile
│       └── README.md
├── app2
│   └── version1
│       ├── Dockerfile
│       └── README.md
├── README.md  # Do not edit this file!
└── writeREADME.sh
</pre>

Each Dockerfile should reside in its own directory with a \`README.md\` with this template:
\`\`\`
<name of main app> <version> <suffix or other important info>

<homepage of main app>

Usage on Rivanna:
    \`\`\`
    module load singularity
    singularity pull docker://uvarc/<app>:<tag>
    ./<app>_<tag>.sif
    \`\`\`
\`\`\`

Individual \`README.md\` files are used as the Docker Hub repository description.

Note: We may need to structure this repo as \`/app/version/Dockerfile\` later.

## Instructions for Contribution

1. Install the following utilities if not on our machine:
    * \`docker\`
    * \`docker-pushrm\` - add-on to push \`README.md\`  
    https://github.com/christian-korneck/docker-pushrm
    * \`git\`
1. Clone this repository
1. Build and test
    1. Prepare a \`Dockerfile\`
    1. Build with explicit tag (do not use \`latest\`): \`docker build -t uvarc/<app>:<tag>\`  
       Use the app version (and suffix if needed) as the tag
    1. Test locally (or on Rivanna - see below)
1. Write \`README.md\` for the app
1. Deploy
    1. Login to Docker Hub: \`docker login\`
    1. Push image to Docker Hub: \`docker push uvarc/<app>:<tag>\`
    1. Push \`README.md\` to Docker Hub (in subdirectory): \`docker pushrm uvarc/<app>\`
    1. Push to GitHub: \`git add . && git commit -m "your message" && git push\`
    1. Remember to logout: \`docker logout\`
1. Run on Rivanna
    1. \`module load singularity\`
    1. \`singularity pull docker://uvarc/<app>:<tag>\`
    1. To run the default command specified in \`ENTRYPOINT\`:  
       \`./<app>_<tag>.sif\`  
       Otherwise:  
       \`singularity exec <app>_<tag>.sif <command>\` or  
       \`singularity shell <app>_<tag>.sif\`

## $LIST

(Link to Docker Hub repository)

|App|Base Image|Compressed Size|Last Updated (UTC)|By|
|---|---|---:|---|---|
EOF

for i in *;  do
    if [ -e $i/Dockerfile ]; then
        get_image_info $i

        # base image
        base=$(awk '{if(NR==1) print $2}' $i/Dockerfile)

        # size in MB
        size=$(awk -F':' '/full_size/ {
            if ($2>1e9) printf "%.3f GB", $2/1024/1024/1024
            else printf "%.3f MB", $2/1024/1024
        }' $TMP)

        # last updated
        lastup=$(sed -n 's/"last_updated":"\(.*\)T\(.*\)Z"$/\1 \2/p' $TMP)

        # last updated by
        lastby=$(sed -n 's/"last_updater_username":"\(.*\)"$/\1/p' $TMP)

        echo "| [$i](https://hub.docker.com/r/uvarc/$i) | \`$base\` | $size | $lastup | \`$lastby\` |" >>$README
    fi
done

echo >>$README

rm $TMP
