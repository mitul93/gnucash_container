REPOSITORY_NAME:=gnucash_container
DOCKER_IMAGE_NAME:=gnucash_container

# container
CONTAINER_BASE_IMAGE_NAME:=debian
CONTAINER_BASE_IMAGE_TAG:=trixie-slim

CONTAINER_USERNAME=gnucash
CONTAINER_USER_UID=$(shell id -u)
CONTAINER_USER_GID=$(shell id -g)