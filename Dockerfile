ARG DEBUG_APT=/dev/stdout

FROM ubuntu:bionic AS embryo

MAINTAINER Martin Kjellstrand [https://www.github.com/madworx]

ARG PYTHON_VERSION
ARG VCS_REF
ARG DEBUG_APT
LABEL org.label-schema.vcs-url="https://github.com/madworx/robotframework-kicadlibrary/" \
      org.label-schema.vcs-ref=${VCS_REF} \
      maintainer="Martin Kjellstrand [https://www.github.com/madworx]"

SHELL [ "/bin/bash", "-c" ]

RUN if [[ "${PYTHON_VERSION}" == 3* ]] ; then PYPKG="python3" ; KIREPO="5.1" ; else PYPKG="python" ; KIREPO="5" ; fi \
    && echo "Adding 'ppa:ja-reynaud/kicad-${KIREPO}' with '${PYPKG}'..." \
    && apt-get -qq update < /dev/null > ${DEBUG_APT} \
    && apt-get -qq install --no-install-recommends --assume-yes software-properties-common locales make < /dev/null > ${DEBUG_APT} \
    && echo "C.UTF-8 UTF-8" > /etc/locale.gen && locale-gen \
    && add-apt-repository -y ppa:js-reynaud/kicad-${KIREPO} < /dev/null > ${DEBUG_APT} \
    && dpkg --purge software-properties-common < /dev/null > ${DEBUG_APT} \
    && apt-get -qq update < /dev/null > ${DEBUG_APT} \
    && apt-get install --assume-yes --no-install-recommends "${PYPKG}" "${PYPKG}-pip"  < /dev/null > ${DEBUG_APT} \
    && if [[ "${PYTHON_VERSION}" == 3* ]] ; then ln -sf python3 /usr/bin/python ; ln -sf pip3 /usr/bin/pip ; fi \
    && apt-get install -qq --assume-yes --no-install-recommends kicad kicad-symbols kicad-footprints < /dev/null > ${DEBUG_APT} \
    && apt-get autoremove -y < /dev/null > ${DEBUG_APT} \
    && apt-get update -o'Dir::Etc::SourceList=/dev/null' -o'Dir::Etc::SourceParts=/tmp' \
    && apt-get clean

FROM embryo AS build
#
# We  are  relying on  the  builder  to set  the  KICADLIBRARY_VERSION
# variable, to  not having  to install  setuptools_scm and  git. (Plus
# having  to deal  with if  this repository  is checked  out as  a git
# submodule (in which case the build would fail any way).
#
ARG KICADLIBRARY_VERSION
ARG DEBUG_APT
RUN if [ -z "${KICADLIBRARY_VERSION}" ] ; then \
       echo "FATAL: Build variable KICADLIBRARY_VERSION must be specified for docker builds!" 1>&2 \
       ; exit 1 \
    ; fi

RUN echo "Installing setuptools into build environment..." \
    && pip install setuptools setuptools_scm wheel

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
