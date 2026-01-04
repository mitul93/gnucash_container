REPOSITORY_NAME:=gnucash_docker
DOCKER_IMAGE_NAME:=gnucash_docker

# docker
DOCKER_BASE_IMAGE_NAME:=ubuntu
DOCKER_BASE_IMAGE_TAG:=24.04

DOCKER_USERNAME=gnucash
DOCKER_USER_UID=$(shell id -u)
DOCKER_USER_GID=$(shell id -g)