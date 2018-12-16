#! /bin/bash

set

if [[ ! -z '${TAGGED_VERSION}' ]] ; then
    source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/master/src/cd-ci-glue.bash')
    dockerhub_push_image 'madworx/robotframework-kicadlibrary:${TAGGED_VERSION}'
    dockerhub_set_description 'madworx/robotframework-kicadlibrary' README.md
fi
