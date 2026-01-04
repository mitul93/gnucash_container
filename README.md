# GnuCash Docker Container

This project provides a **Docker container to run GnuCash** (GNU Accounting Software) using Ubuntu package.

It is useful for isolating GnuCash from your host system, managing dependencies, and running it safely in containers.

---

## Features

- Installs **GnuCash** using Ubuntu’s official packages.
- Prepares the **home directories** (`~/.config`, `~/.share`, etc.) to prevent GTK/dconf warnings.
- Fixes common GUI issues:
  - `dconf-WARNING: failed to commit changes`
  - `MIT-SHM` errors
  - Missing GTK icons or SVGs

## Tested with

- Docker Compose v2.40.3
- Make 4.3 (if want to launch program via make)
- Host OS : Ubuntu 24.04 6.8.0-90-generic
- GnuCash 5.5 Build ID: 5.5+(2023-12-16)

## Data Mapping / Persistent Storage

> ⚠️ Use **~/gnucash_data** container directory to save GNU Cash user data.  
> This ensures that all of your accounting data persists between docker runs.

Following settings ensures persistent storage of application and user data. By default, GnuCash inside the container stores:

| Host Path             | Container Path            | Type              |
|-----------------------|---------------------------|:-----------------:|
| `data/share/gnucash`  | ~/.local/share/gnucash/   | Application Data  |
| `data/config/gnucash` | ~/.config/gnucash         | Application Data  |
| `data/gnucash_data`   | ~/gnucash_data            | User Data         |

You can override these mappings in `docker-compose.yaml` file.

More information about Application Data paths available at https://wiki.gnucash.org/wiki/Configuration_Locations#System-wide

The docker container will run as local user UID:GID. Make sure you have permissions to read/write `gnucash_docker/data` directory.

## Build and run docker image

```
cd gnucash_docker
make run_gnucash
```

OR

```
cd gnucash_docker
mkdir -p data/config/gnucash data/share/gnucash data/gnucash_data
docker compose up --build
```



