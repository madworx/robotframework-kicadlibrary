SHELL = bash

all: tests doc

setup:

tests: setup
	python setup.py test

dist: clean tests
	python setup.py sdist bdist_wheel

docker:
	export KICADLIBRARY_VERSION="$$(python setup.py --get-version)" ; \
	export VCS_REF="$$(git rev-parse --short HEAD)" ; \
	docker build -t "madworx/robotframework-kicadlibrary:$${KICADLIBRARY_VERSION/+/-}" --build-arg=KICADLIBRARY_VERSION --build-arg=VCS_REF .

docker-extract-artifacts:
	export KICADLIBRARY_VERSION="$$(python setup.py --get-version)" ; \
	docker run --rm --entrypoint /bin/tar "madworx/robotframework-kicadlibrary:$${KICADLIBRARY_VERSION/+/-}" cf - build | tar xvf -

setup-environment:
	pip install . --user
	pip install coverage --user

doc:
	python setup.py build_rf_docs

clean:
	find . -type f \( -name '*.pyc' -o -name coverage.xml -o -name .coverage -o -name nosetests.xml -o -name pylint-report.txt -o -name '*~' -o -name '#*#' \) -delete

distclean:	clean
	find . -depth -type d \( -name '*.eggs' -o -name '*.egg-info' -o -name '__pycache__' -o -name '.pytest_cache' -o -name '.cache' -o -name '.scannerwork' -o -name 'dist' -o -name 'docs' -o -name 'build' \) -print0 | xargs -r0 rm -r
