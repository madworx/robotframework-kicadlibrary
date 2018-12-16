#! /bin/bash

set -x

set

if [[ ! -z '${TAGGED_VERSION}' ]] ; then
    echo "We are on par with a tagged release -- deploying to github."
    source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/master/src/cd-ci-glue.bash')
    dockerhub_push_image 'madworx/robotframework-kicadlibrary:${TAGGED_VERSION}'
    dockerhub_set_description 'madworx/robotframework-kicadlibrary' README.md
fi
