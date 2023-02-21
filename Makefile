.PHONY: fmt-check lint fmt

fmt-check:
	crystal tool format --check src spec examples

lint:
	shards install
	./bin/ameba src examples

fmt:
	crystal tool format src spec examples

docs-build:
	crystal run docs/doc_drawings.cr
	cd docs && make site-build
