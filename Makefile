.PHONY: build

OLD_CONTAINER_NAME=flomotlik/awsinfo
CONTAINER_NAME=theserverlessway/awsinfo
CONTAINER=$(CONTAINER_NAME):dev
TEST_HELPERS=tests/test-helpers
TESTFILES=tests/commands/**/*.bats tests/commands/*.bats
GIT_COMMIT=$(shell git rev-parse HEAD)
DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

BUILD_ARGS=--build-arg AWSINFO_VERSION="$(DATE)-$(GIT_COMMIT)" -t $(CONTAINER) .


build:
	docker build $(BUILD_ARGS)

build-no-cache:
	docker build --pull --no-cache $(BUILD_ARGS)

install: build-no-cache
	docker tag $(CONTAINER) $(CONTAINER_NAME):latest

release: install
	docker push $(CONTAINER_NAME):latest
	docker tag $(CONTAINER_NAME):latest $(OLD_CONTAINER_NAME):latest
	docker push $(OLD_CONTAINER_NAME):latest

test: build-no-cache
	STACKPOSTFIX=$(shell date +%s%N) ./tests/test-helpers/bats/bin/bats $(TESTFILES)

shell: build
	docker run --entrypoint bash -it -v ~/.aws:/root/.aws -v `pwd`:/awsinfo -w /awsinfo -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE $(CONTAINER)

prepare:
	pip install formica-cli -U
	pip install awscli -U
	pip install awsie -U

command-docs:
	@find scripts/commands -name "*.bash" | awk '{sub(/\.bash/, "", $$0); n=split($$0,file,"/"); sub(/index/, "", file[n]); print "* [`" file[n-1] " " file[n] " `](https://github.com/theserverlessway/awsinfo/blob/master/" $$0 ".md)" }' | sort | sed "s/[[:space:]]\+\`/\`/g"

LOG_TIMESTAMP=$(shell echo $$(($$(date +%s) * 1000)))
LOG_STREAM_NAME=test-log-stream-$(LOG_TIMESTAMP)

put-log-message:
	aws logs create-log-stream --log-group-name test-log-group --log-stream-name $(LOG_STREAM_NAME)
	aws logs put-log-events --log-group-name test-log-group --log-stream-name  $(LOG_STREAM_NAME) --log-events timestamp=$(LOG_TIMESTAMP),message=TestMessage-$(LOG_TIMESTAMP)

FORMICA_STACK=awsinfo-integration-user
create-integration-user:
	cd tests && formica new --stack $(FORMICA_STACK) --capabilities CAPABILITY_IAM
	formica deploy --stack $(FORMICA_STACK)

update-integration-user:
	cd tests && formica change --stack $(FORMICA_STACK) --capabilities CAPABILITY_IAM
	formica deploy --stack $(FORMICA_STACK)

Command=index
COMMANDS_DIR=scripts/commands
EXAMPLE_DIR=scripts/command_example

SERVICE=${shell }

create:
	@read -p "Enter the Service Name: " SERVICE_NAME; \
	if [ -z "$$SERVICE_NAME" ]; then echo "You need to set the Service Name"; exit 1; fi; \
	read -p "Enter the Command Name [index]: " COMMAND_NAME_INPUT; \
	COMMAND_NAME=$${COMMAND_NAME_INPUT:-index}; \
	mkdir -p $(COMMANDS_DIR)/$$SERVICE_NAME && cp $(EXAMPLE_DIR)/command.bash $(COMMANDS_DIR)/$$SERVICE_NAME/$$COMMAND_NAME.bash && cp $(EXAMPLE_DIR)/command.md $(COMMANDS_DIR)/$$SERVICE_NAME/$$COMMAND_NAME.md

new:


