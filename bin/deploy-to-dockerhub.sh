#! /bin/bash

export TAGGED_VERSION="$(git describe --exact-match HEAD 2>/dev/null)"
export DOCKER_USERNAME="$1"
export DOCKER_PASSWORD="$2"

if [[ ! -z "${TAGGED_VERSION}" ]] ; then
    echo "We are on par with a tagged release -- deploying to github."
    source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/master/src/cd-ci-glue.bash')
    dockerhub_push_image "madworx/robotframework-kicadlibrary:${TAGGED_VERSION}"
    dockerhub_set_description 'madworx/robotframework-kicadlibrary' README.md
fi

exit 0
