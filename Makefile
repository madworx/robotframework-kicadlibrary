all: tests doc

setup:

tests: setup
	python setup.py test

dist: clean tests
	python setup.py sdist bdist_wheel

setup-environment:
	pip install . --user
	pip install coverage --user

doc:
	python setup.py build_rf_docs

clean:
	find . -type f \( -name '*.pyc' -o -name coverage.xml -o -name .coverage -o -name nosetests.xml -o -name pylint-report.txt -o -name '*~' -o -name '#*#' \) -delete

distclean:	clean
	find . -depth -type d \( -name '*.eggs' -o -name '*.egg-info' -o -name '__pycache__' -o -name '.pytest_cache' -o -name '.cache' -o -name '.scannerwork' -o -name 'dist' -o -name 'docs' -o -name 'build' \) -print0 | xargs -r0 rm -r
