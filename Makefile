ROOT_PATH := $(shell pwd)
COLLECTION_PATH := $(ROOT_PATH)/collections/ansible_collections/rhsiqe/skupper
TAR_NAME := rhsiqe-skupper-0.1.0.tar.gz
TAR_PATH := $(COLLECTION_PATH)/$(TAR_NAME)

build:
	@cd $(COLLECTION_PATH) && \
	ansible-galaxy collection build --force && \
	ansible-galaxy collection install -f $(TAR_PATH) --force && \
	cd $(ROOT_PATH)
	rm -rf $(COLLECTION_PATH)/$(TAR_NAME)
	
test:
	@./run_all_tests.sh
