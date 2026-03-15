include make/env.mk

######################################################
#################### devcontainer ####################
######################################################

# generate docker compose env file for devcontainer
DEVCONTAINER_BUILD_TIME_ENV_FILE := .env

.PHONY: generate_compose_env
generate_compose_env:
	@rm -rf $(DEVCONTAINER_BUILD_TIME_ENV_FILE)

	@echo "DOCKER_BASE_IMAGE_NAME=${DOCKER_BASE_IMAGE_NAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_BASE_IMAGE_TAG=${DOCKER_BASE_IMAGE_TAG}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	
	@echo "REPOSITORY_NAME=${REPOSITORY_NAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USERNAME=${DOCKER_USERNAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USER_UID=${DOCKER_USER_UID}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USER_GID=${DOCKER_USER_GID}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)

.PHONY: run_gnucash
run_gnucash: generate_compose_env
	@mkdir -p storage/config/dconf storage/config/gnucash storage/share/gnucash storage/gnucash_user_data
	@podman-compose up