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

> ⚠️ Use **~/gnucash_user_data** container directory to save GNU Cash user data.  
> This ensures that all of your accounting data persists between docker runs.

Following settings ensures persistent storage of application and user data. By default, GnuCash inside the container stores:

| Host Path                     | Container Path            | Type              |
|-------------------------------|---------------------------|:-----------------:|
| `storage/share/gnucash/`      | ~/.local/share/gnucash/   | Application Data  |
| `storage/config/gnucash`      | ~/.config/gnucash         | Application Data  |
| `storage/config/dconf`        | ~/.config/dconf           | GSettings         |
| `storage/gnucash_user_data`   | ~/gnucash_user_data       | User Data         |

You can override these mappings in `docker-compose.yaml` file.

More information about Application Data paths available at https://wiki.gnucash.org/wiki/Configuration_Locations#System-wide

The docker container will run as local user UID:GID with username `gnucash` . Make sure you have permissions to read/write `gnucash_docker/storage` directory.

## GNU Cash storage backend

GNU Cash supports **XML**, **SQLite**, **MySQL** and **PostgreSQL** as storage backend. 

More information https://www.gnucash.org/docs/v5/C/gnucash-guide/basics-files1.html

Linux requires additional package installtion to use SQL backends. This project configures GNU Cash with SQLite.

If you want to use another storage backend, update value of `GNUCASH_STORAGE_BACKEND` variable in file `make/env.mk`
It accepts comma separated values.

Example values
```
GNUCASH_STORAGE_BACKEND:=SQLite
GNUCASH_STORAGE_BACKEND:=SQLite, MySQL
GNUCASH_STORAGE_BACKEND:=MySQL, PostgreSQL, SQLite
```


## Build and run docker image

```
cd gnucash_docker
make run_gnucash
```

## Troubleshooting

Remove `.evn` file and run `make run_gnucash`

Run `make generate_compose_env && docker compose config` to view docker compose file config.