# robotframework-kicadlibrary

[![Build Status](https://travis-ci.org/madworx/robotframework-kicadlibrary.svg?branch=master)](https://travis-ci.org/madworx/robotframework-kicadlibrary) [![Sonarcloud quality](https://sonarcloud.io/api/project_badges/measure?project=robotframework-kicadlibrary&metric=alert_status)](https://sonarcloud.io/dashboard?id=robotframework-kicadlibrary) [![Updates](https://pyup.io/repos/github/madworx/robotframework-kicadlibrary/shield.svg)](https://pyup.io/repos/github/madworx/robotframework-kicadlibrary/) [![Code coverage](https://sonarcloud.io/api/project_badges/measure?project=robotframework-kicadlibrary&metric=coverage)](https://sonarcloud.io/component_measures?id=robotframework-kicadlibrary&metric=coverage) [![PyPI version](https://badge.fury.io/py/robotframework-kicadlibrary.svg)](https://badge.fury.io/py/robotframework-kicadlibrary) [![Docker image version](https://images.microbadger.com/badges/version/madworx/robotframework-kicadlibrary.svg)](https://hub.docker.com/r/madworx/robotframework-kicadlibrary)

[![Build history](https://buildstats.info/travisci/chart/madworx/robotframework-kicadlibrary?branch=master)](https://travis-ci.org/madworx/robotframework-kicadlibrary/builds)

A [Robot Framework](http://robotframework.org/) library for validating [KiCad](http://kicad-pcb.org/) designs.

Releases are available via regular [PyPI](https://pypi.org/project/robotframework-kicadlibrary/) as well as [GitHib releases](https://github.com/madworx/robotframework-kicadlibrary/releases). Example projects/usage is available under the `examples/` sub-directory.

[Keyword documentation](https://madworx.github.io/robotframework-kicadlibrary/KiCadLibrary.html) is available online, as well as downloadable via [GitHub Releases](https://github.com/madworx/robotframework-kicadlibrary/releases/latest).

## Getting Started

### Prerequisites

You'll need an installation of Python, as well as `pip`. Please see your operating systems documentation on how to install those tools.

You will also need Robot Framework installed, but if you install using `pip`, robot framework will automatically be installed for you.

### Installing

Installing using pip:

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
