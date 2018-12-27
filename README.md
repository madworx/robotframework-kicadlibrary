# robotframework-kicadlibrary

[![Build Status](https://travis-ci.org/madworx/robotframework-kicadlibrary.svg?branch=master)](https://travis-ci.org/madworx/robotframework-kicadlibrary) [![Sonarcloud quality](https://sonarcloud.io/api/project_badges/measure?project=robotframework-kicadlibrary&metric=alert_status)](https://sonarcloud.io/dashboard?id=robotframework-kicadlibrary) [![Updates](https://pyup.io/repos/github/madworx/robotframework-kicadlibrary/shield.svg)](https://pyup.io/repos/github/madworx/robotframework-kicadlibrary/) [![Code coverage](https://sonarcloud.io/api/project_badges/measure?project=robotframework-kicadlibrary&metric=coverage)](https://sonarcloud.io/component_measures?id=robotframework-kicadlibrary&metric=coverage) [![PyPI version](https://badge.fury.io/py/robotframework-kicadlibrary.svg)](https://badge.fury.io/py/robotframework-kicadlibrary) [![Docker image version](https://images.microbadger.com/badges/version/madworx/robotframework-kicadlibrary.svg)](https://hub.docker.com/r/madworx/robotframework-kicadlibrary)

[![Build history](https://buildstats.info/travisci/chart/madworx/robotframework-kicadlibrary?branch=master)](https://travis-ci.org/madworx/robotframework-kicadlibrary/builds)

A [Robot Framework](http://robotframework.org/) library for validating [KiCad](http://kicad-pcb.org/) designs.

Releases are available via regular [PyPI](https://pypi.org/project/robotframework-kicadlibrary/) as well as [GitHib releases](https://github.com/madworx/robotframework-kicadlibrary/releases). Example projects/usage is available under the `examples/` sub-directory.

[Keyword documentation](https://madworx.github.io/robotframework-kicadlibrary/KiCadLibrary.html) is available online, as well as downloadable via [GitHub Releases](https://github.com/madworx/robotframework-kicadlibrary/releases/latest).

## Getting Started

### Prerequisites

You'll need an installation of Python, as well as `pip` and a working
installation of KiCad. Please consult your operating system
documentation on how to install these tools.

You will also need Robot Framework installed, but if you're installing
using `pip`, Robot Framework will automatically be installed for you.

### Installing KiCad, PIP and the library

This is dependent on your local operating system, but if you'te running
any form of Unix-clone, it should typically be something in the lines of:

```
# Debian based systems
$ sudo apt-get install python-pip kicad
$ sudo pip install robotframework-kicadlibrary

# RedHat based systems:
$ sudo yum -y install epel-release
$ sudo yum -y install python-pip kicad
$ sudo pip install robotframework-kicadlibrary
```

### Installing using PIP with existing environment

```
$ pip install robotframework-kicadlibrary
```

## Using the library

```
*** Variables ***
Library    KiCadLibrary    schema=myproject.sch    pcb=myproject.kicad_pcb

*** Test cases ***
Module pads should be on grid
    Module Pads Should Be On Grid    50 mil    reference=.*$
```

## Contributing

Any and all contributions are welcome, in the form of [pull requests](https://github.com/madworx/robotframework-kicadlibrary/pulls).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [releases on this repository](https://github.com/madworx/robotframework-kicadlibrary/releases).

## Authors

* **Martin Kjellstrand** - *Initial work* - [madworx](https://github.com/madworx)

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

## Developer information / Preparing a release

To create a release please follow this outline:

* Do your development work in a separate branch.
* Write unit-tests (`tests/`) and/or integration tests (`examples/`) for your code.
* Once all local tests validate, and you have 100% code coverage, push to GitHub.

### If you have commit access to the main repository

* Once build hooks at Github/Sonarcloud/pyup etc have completed, tag a pre-release (`x.y.zrc0`)
* If that build completes, perform a PR into `master`, squashing the commit history.
* Tag the `master` branch with the new release version, ahdering to semantic versioning.
* Remove any `pre` artifacts from Docker Hub and PyPI.
* Delete the `rc*` tags from the repository.
  `git tag -d x.y.zrcN`, followed by `git push origin :x.y.zpreN`.

### If you don't have commit access to the main repository

* Submit a PR towards the `master` branch of the [main repository](https://github.com/madworx/robotframework-kicadlibrary/).