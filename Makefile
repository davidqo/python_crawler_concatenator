DIR=$(shell pwd)

SDK_DIR=$(DIR)/sdk
SDK_EXEC=$(SDK_DIR)/local/bin/
PYTHON=$(SDK_EXEC)/python
EASY_INSTALL=$(SDK_EXEC)/easy_install
BIN_DIR=$(DIR)/bin

DEPS=beautifulsoup4 lxml scrapy

all: deps compile

prepare:
	virtualenv $(SDK_DIR) && virtualenv $(SDK_DIR) --relocatable

deps: 
	for x in $(DEPS) ; do \
		$(EASY_INSTALL) $$x ; \
	done

compile: 
	$(PYTHON) setup.py install --install-lib bin

clean-all: clean clean-sdk

clean:
	rm -rf build && rm -rf bin

clean-sdk:
	rm -rf sdk

run:
	PATH=$(SDK_DIR):$(PATH) $(PYTHON) $(BIN_DIR)/crawler

run-shell:
	PATH=$(SDK_DIR):$(PATH) $(PYTHON) -i $(BIN_DIR)/crawler

.PHONY: all prepare clean-sdk compile clean clean-all deps run run-shell

