PREFIX ?= /usr/local/bin

.PHONY: install uninstall test

install:
	PREFIX=$(PREFIX) ./setup.sh

uninstall:
	rm -f $(PREFIX)/ecodex $(PREFIX)/ecodex-log
	echo "Removed ecodex and ecodex-log from $(PREFIX)"

test:
	./ecodex --test
