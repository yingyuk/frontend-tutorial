BOOK_NAME := frontend-tutorial
BOOK_OUTPUT := _book

.PHONY: build
build:
	gitbook build . $(BOOK_OUTPUT)

.PHONY: serve
serve:
	gitbook serve . $(BOOK_OUTPUT)

.PHONY: install
install:
	npm install gitbook-cli -g
	gitbook install

.PHONY: clean
clean:
	rm -rf $(BOOK_OUTPUT)

.PHONY: help
help:
	@echo "Help for make"
	@echo "make          - Build the book"
	@echo "make build    - Build the book"
	@echo "make serve    - Serving the book on localhost:4000"
	@echo "make install  - Install gitbook and plugins"
	@echo "make clean    - Remove generated files"