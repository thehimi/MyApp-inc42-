# Images to be pushed to registry
APPS := django nginx postgres

REGISTRY := registery_id

GET_TAG := $(shell git rev-parse --short --verify HEAD)-$(shell date +%Y%m%d%H%M%S)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

TAG_APP = docker tag app_$(APP):$(GET_TAG) ${REGISTRY}/app_$(APP):$(GET_TAG);
PUSH_APP = docker push ${REGISTRY}/app_$(APP):$(GET_TAG);

help :
	@echo make build - builds and tags local docker images
	@echo make run - builds and runs locally
	@echo make tag - build + tag images for repository
	@echo make push - builds, tags and pushes to repo

build : setdockerversion
	echo $(GET_TAG) > last_built_version_tag
	echo $(GIT_BRANCH) > git_branch
	export VERSION_TAG=$(GET_TAG) && docker compose --file production.yml build --pull

run : build
	export VERSION_TAG=$(GET_TAG) && docker compose  --file production.yml up -d

tag : build
	$(foreach APP,$(APPS),$(TAG_APP))

push : tag
	$(foreach APP,$(APPS),$(PUSH_APP))
	$(call post-release-notes)
	cat last_built_version_tag
	cat git_branch
	cat version_number