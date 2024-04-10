install:
	python venv venv
	venv/bin/python -m pip install -r r.txt

build:
	venv/bin/python -m mkdocs build