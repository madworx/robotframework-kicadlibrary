#! /bin/bash

set -x

export TAGGED_VERSION="$(git describe --exact-match HEAD 2>/dev/null)"
export DOCKER_USERNAME="$1"
export DOCKER_PASSWORD="$2"
export GH_TOKEN="$3"

# Test: Always deploy to github pages:
source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/publish-to-github-pages/src/cd-ci-glue.bash')
pushd .
GHDIR=$(github_pages_prepare 'madworx/robotframework-kicadlibrary' 'gh-pages') || exit 1
echo "Temporary documentation checkout directory is: ${GHDIR}"
cp build/*.html "${GHDIR}/"
github_doc_commit "${GHDIR}"
popd

if [[ ! -z "${TAGGED_VERSION}" ]] ; then
    echo "We are on par with a tagged release -- deploying to github."
    source <(curl 'https://raw.githubusercontent.com/madworx/cd-ci-glue/master/src/cd-ci-glue.bash')
    dockerhub_push_image "madworx/robotframework-kicadlibrary:${TAGGED_VERSION}"
    dockerhub_set_description 'madworx/robotframework-kicadlibrary' README.md
fi

exit 0
