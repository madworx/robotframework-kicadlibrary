#! /bin/bash

export TAGGED_VERSION="$(git describe --exact-match HEAD 2>/dev/null)"
export DOCKER_USERNAME="$1"
export DOCKER_PASSWORD="$2"
export GH_TOKEN="$3"

if [[ ! -z "${TAGGED_VERSION}" ]] ; then
    echo "We are on par with a tagged release."
    echo ""
    echo "Deploying to Docker Hub."
    source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/master/src/cd-ci-glue.bash')
    docker tag "madworx/robotframework-kicadlibrary:${TAGGED_VERSION}" "madworx/robotframework-kicadlibrary:latest"
    dockerhub_push_image "madworx/robotframework-kicadlibrary:${TAGGED_VERSION}"
    dockerhub_push_image "madworx/robotframework-kicadlibrary:latest"
    dockerhub_set_description 'madworx/robotframework-kicadlibrary' README.md

    echo "Publishing generated documentation to GitHub Pages."
    pushd .
    GHDIR=$(github_pages_prepare 'madworx/robotframework-kicadlibrary' 'gh-pages') || exit 1
    cp build/*.html "${GHDIR}/"
    cp build/*.html "${GHDIR}/KiCadLibrary.html"
    github_doc_commit "${GHDIR}"
    popd
fi

exit 0
