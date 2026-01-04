REPOSITORY_NAME:=gnucash_docker
DOCKER_IMAGE_NAME:=gnucash_docker

# docker
DOCKER_BASE_IMAGE_NAME:=ubuntu
DOCKER_BASE_IMAGE_TAG:=24.04

DOCKER_USERNAME=$(shell whoami)
DOCKER_UID=$(shell id -u)
DOCKER_GID=$(shell id -g)