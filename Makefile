include make/env.mk

######################################################
#################### devcontainer ####################
######################################################

# generate docker compose env file for devcontainer
DEVCONTAINER_BUILD_TIME_ENV_FILE := .env

.PHONY: generate_devcontainer_env
generate_devcontainer_env:
	@rm -rf $(DEVCONTAINER_BUILD_TIME_ENV_FILE)

	@echo "DOCKER_BASE_IMAGE_NAME=${DOCKER_BASE_IMAGE_NAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_BASE_IMAGE_TAG=${DOCKER_BASE_IMAGE_TAG}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)

	@echo "REPOSITORY_NAME=${REPOSITORY_NAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USERNAME=${DOCKER_USERNAME}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USER_UID=${DOCKER_USER_UID}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)
	@echo "DOCKER_USER_GID=${DOCKER_USER_GID}" >> $(DEVCONTAINER_BUILD_TIME_ENV_FILE)

.PHONY: run_gnucash
run_gnucash: generate_devcontainer_env
	@mkdir -p data/config/gnucash data/share/gnucash data/gnucash_data
	@docker compose up --build
