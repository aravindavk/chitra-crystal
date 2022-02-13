.PHONY: fmt-check lint fmt

fmt-check:
	crystal tool format --check src

lint:
	shards install
	./bin/ameba src

fmt:
	crystal tool format src

docs-build:
	crystal run docs/doc_drawings.cr
	cd docs && make site-build
