ARG CONTAINER_BASE_IMAGE_NAME=debian
ARG CONTAINER_BASE_IMAGE_TAG=trixie-slim
FROM ${CONTAINER_BASE_IMAGE_NAME}:${CONTAINER_BASE_IMAGE_TAG}

# set timezone
ENV TZ="Etc/UTC"

# noninteractive debian frontend
ARG DEBIAN_FRONTEND=noninteractive

# set locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# install apt packages and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata \
    # gnucash
    libcanberra-gtk3-module dbus-x11 librsvg2-common gir1.2-gtk-3.0 python3-gi \ 
    libdbd-sqlite3 \ 
    # libdbd-mysql \
    # libdbd-pgsql \
    gnucash python3-gnucash && \
    rm -rf /var/lib/apt/lists/*

# add user to usergroup
ARG USERNAME=gnucash
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} ${USERNAME} &&\
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

# user name
USER ${USERNAME}

RUN mkdir -p ~/.config/gnucash ~/.local/share/gnucash

# working directory
ARG REPOSITORY_NAME=gnucash_docker
WORKDIR /${REPOSITORY_NAME}

# entry point
ENTRYPOINT ["gnucash"]