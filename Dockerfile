FROM ubuntu:bionic AS embryo

MAINTAINER Martin Kjellstrand [https://www.github.com/madworx]

ARG VCS_REF
LABEL org.label-schema.vcs-url="https://github.com/madworx/robotframework-kicadlibrary/" \
      org.label-schema.vcs-ref=${VCS_REF} \
      maintainer="Martin Kjellstrand [https://www.github.com/madworx]"

RUN echo "Adding 'ppa:ja-reynaud/kicad-5' repository and installing..." \
    && apt-get -qq update < /dev/null > /dev/null \
    && apt-get -qq install --assume-yes software-properties-common < /dev/null > /dev/null \
    && add-apt-repository -y ppa:js-reynaud/kicad-5 < /dev/null > /dev/null \
    && dpkg --purge software-properties-common < /dev/null > /dev/null \
    && apt-get autoremove -y < /dev/null > /dev/null \
    && apt-get -qq update < /dev/null > /dev/null \
    && apt-get install -qq --assume-yes --no-install-recommends \
                     kicad kicad-symbols kicad-footprints python \
                     python-pip < /dev/null > /dev/null

FROM embryo AS build
#
# We  are  relying on  the  builder  to set  the  KICADLIBRARY_VERSION
# variable, to  not having  to install  setuptools_scm and  git. (Plus
# having  to deal  with if  this repository  is checked  out as  a git
# submodule (in which case the build would fail any way).
#
ARG KICADLIBRARY_VERSION
RUN if [ -z "${KICADLIBRARY_VERSION}" ] ; then \
       echo "FATAL: Build variable KICADLIBRARY_VERSION must be specified for docker builds!" 1>&2 \
       ; exit 1 \
    ; fi

RUN echo "Installing setuptools and make into build environment..." \
    && pip install setuptools setuptools_scm wheel \
    && apt-get install -qq --assume-yes --no-install-recommends \
       make < /dev/null > /dev/null

COPY . /build
WORKDIR /build
RUN make distclean
RUN echo "Building version ${KICADLIBRARY_VERSION}."
RUN sed -e "s#'setuptools_scm', ##g" \
        -e "/use_scm_version/d" \
        -e "s/#version=.*/version='${KICADLIBRARY_VERSION}',/g" \
        -i setup.py

# Run unit-tests and build wheel.
RUN make dist doc
RUN pip install dist/*.whl

# Run integration tests
RUN cd examples \
    && for DIR in * ; do \
       ( cd "${DIR}" && robot . ) \
       ; done

FROM embryo
COPY --from=build \
     /build/dist/*.whl \
     /build/dist/*.tar.gz \
     /build/docs/*.html \
     /build/build/coverage.xml \
     /build/build/nosetests.xml \
     /build/
     
RUN pip install /build/*.whl
RUN useradd --base-dir / \
            --system \
            --user-group \
            --create-home \
            robot
USER robot
ENTRYPOINT [ "/usr/local/bin/robot" ]
