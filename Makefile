.PHONY: test clean coverage lint distclean release

PYTHON ?= python3

test:
	$(PYTHON) setup.py test

clean:
	rm -rf dist/ build/ *.egg-info
	rm -rf coverage.xml
	find . -name '__pycache__' | xargs rm -rf

distclean: clean

coverage:
	coverage run --source zxtools setup.py test
	coverage report -m --fail-under=80

lint:
	pylint zxtools -f parseable -r n

release: clean lint coverage clean
	$(PYTHON) setup.py sdist bdist_wheel upload

