REPOSITORY_NAME:=gnucash_docker
DOCKER_IMAGE_NAME:=gnucash_docker

# docker
DOCKER_BASE_IMAGE_NAME:=ubuntu
DOCKER_BASE_IMAGE_TAG:=24.04

CONTAINER_USERNAME=gnucash
CONTAINER_USER_UID=$(shell id -u)
CONTAINER_USER_GID=$(shell id -g)

# GNU Cash storage backend. Valid values - SQLite, MySQL, PostgreSQL
# You can write multiple values separated by comma eg. SQLite,PostGreSQL
# https://www.gnucash.org/docs/v5/C/gnucash-guide/basics-files1.html
GNUCASH_STORAGE_BACKEND:=SQLite

##### helper scripts #####

# Convert comma-separated input to space-separated and uppercase
GNUCASH_STORAGE_BACKEND_UPPER := $(shell echo $(GNUCASH_STORAGE_BACKEND) | tr '[:lower:]' '[:upper:]' | tr ',' ' ')

# Allowed backends
VALID_GNUCASH_STORAGE_BACKEND := SQLITE MYSQL POSTGRESQL

# Check for invalid backends
INVALID_GNUCASH_STORAGE_BACKEND := $(filter-out $(VALID_GNUCASH_STORAGE_BACKEND),$(GNUCASH_STORAGE_BACKEND_UPPER))

# Throw error if there are any invalid backends
ifeq ($(strip $(INVALID_GNUCASH_STORAGE_BACKEND)),)
# All good, do nothing
else
  $(error Invalid backend(s): $(INVALID_GNUCASH_STORAGE_BACKEND). Case insensitive Valid values are : $(VALID_GNUCASH_STORAGE_BACKEND))
endif

# Function to map a single backend to its package
define backend_to_pkg
$(strip $(if $(filter SQLITE,$(1)),libdbd-sqlite3,) \
       $(if $(filter MYSQL,$(1)),libdbd-mysql,) \
       $(if $(filter POSTGRESQL,$(1)),libdbd-pgsql,))
endef