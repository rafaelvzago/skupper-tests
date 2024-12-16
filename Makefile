ROOT_PATH := $(shell pwd)
COLLECTION_PATH := $(ROOT_PATH)/collections/ansible_collections/rhsiqe/skupper
LATEST_TAG := $(shell git describe --tags --abbrev=0)
TAR_NAME := rhsiqe-skupper-$(LATEST_TAG).tar.gz
TAR_PATH := $(COLLECTION_PATH)/$(TAR_NAME)

build:
	@cd $(COLLECTION_PATH) && \
	ansible-galaxy collection build --force && \
	ansible-galaxy collection install -f $(TAR_PATH) --force && \
	cd $(ROOT_PATH)
	rm -rf $(COLLECTION_PATH)/$(TAR_NAME)
	
test:
	@./run_all_tests.sh

hello:
	@ansible-playbook scenarios/hello-world/hello-world.yml -i scenarios/hello-world/inventory/hosts.yml
