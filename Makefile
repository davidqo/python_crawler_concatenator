SDK_DIR=./sdk
SDK_EXEC=$(SDK_DIR)/local/bin/
PYTHON=$(SDK_EXEC)/python
EASY_INSTALL=$(SDK_EXEC)/easy_install
DEPS=beautifulsoup4 lxml scrapy

all: deps compile

prepare:
	virtualenv $(SDK_DIR) && virtualenv $(SDK_DIR) --relocatable

deps: 
	for x in $(DEPS) ; do \
		$(EASY_INSTALL) $$x ; \
	done

compile: 
	python setup.py install --install-lib bin

clean-all: clean clean-sdk

clean:
	rm -rf build && rm -rf bin

clean-sdk:
	rm -rf sdk

run:
	PATH=./sdk:$(PATH) $(PYTHON) -i ./bin/crawler

.PHONY: all prepare clean-sdk compile clean clean-all deps run

