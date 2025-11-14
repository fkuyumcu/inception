# Inception

This project provisions a multi‑container environment using Docker and Docker Compose, deploying a self‑hosted WordPress stack behind Nginx with a MariaDB database. It is structured for reproducibility, isolation, and persistent data storage on the host.

## Stack Overview

Services (defined in srcs/docker-compose.yml):
- Nginx (reverse proxy + TLS termination on port 443)
- WordPress (PHP application container)
- MariaDB (database backend)
- Custom bridge network (network)
- Host‑bound persistent volumes for data

## Features

- Clean separation of concerns (each service has its own build context)
- Persistent data stored under /home/fkuyumcu/data (mapped via bind volumes)
- Makefile helpers to simplify lifecycle management
- Environment variables centralised in a .env file
- Automatic container restart policies

## Directory Structure

```
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── nginx/
        ├── mariadb/
        └── wordpress/
```

Each directory under requirements is expected to contain a Dockerfile and any configuration/assets needed for its service.

## Persistent Data

Bind‑mounted volumes:
- WordPress content: /home/fkuyumcu/data/wordpress -> /var/www/html
- MariaDB data: /home/fkuyumcu/data/mysql -> /var/lib/mysql

These survive container rebuilds. Deleting them (e.g. via make cc) resets application state.

## Prerequisites

- Linux environment (paths assume /home/<user>)
- Docker Engine
- Docker Compose plugin
- make
- A populated .env file (see below)

## Environment Variables

Create a .env file in the project root. Typical variables might include (example placeholders):

```
WORDPRESS_DB_HOST=mariadb
WORDPRESS_DB_USER=wpuser
WORDPRESS_DB_PASSWORD=secure_password
WORDPRESS_DB_NAME=wordpress
MARIADB_ROOT_PASSWORD=another_secure_password
MARIADB_DATABASE=wordpress
MARIADB_USER=wpuser
MARIADB_PASSWORD=secure_password
```

Adjust names to match what your Dockerfiles expect.

## Makefile Targets

The Makefile wraps docker compose (compose file: srcs/docker-compose.yml):

- make or make all  
  Creates host data directories and builds/starts all services in detached mode.

- make down  
  Stops and removes containers (keeps volumes/images).

- make clean  
  Stops containers, removes volumes, orphan containers, and force‑removes all images.

- make re  
  Equivalent to make clean followed by make all (declared via dependency).

- make cc  
  Aggressive cleanup: stops containers, removes volumes, prunes build cache, deletes all images (ignores errors), and deletes host data directories.

Use cc cautiously—data loss is permanent.

## Usage

1. Clone the repository.
2. Create and verify .env.
3. Run:
   ```
   make
   ```
4. Access WordPress via https://localhost (port 443 mapped from nginx).
5. Manage lifecycle with the targets above.

## Networking

A custom bridge network (network) is declared; containers communicate using their service names as hostnames.

## Security & Hardening Suggestions

- Provide valid TLS certificates for Nginx (if self‑signed, document trust setup).
- Use strong, unique passwords in .env.
- Restrict file permissions on the .env file (chmod 600).
- Consider non‑root users inside images.
- Add automated backups for /home/<user>/data contents.

## Troubleshooting

- Containers restart endlessly: check .env variable mismatches (DB credentials).
- Permission errors writing to bind mounts: ensure host directories exist and current user has access before running make.
- Port 443 already in use: free it or change mapping in docker-compose.yml.

## Extending

To add a new service:
1. Create a directory under srcs/requirements/<service>.
2. Add a Dockerfile and config.
3. Reference it in docker-compose.yml with build: ./requirements/<service>.
4. Attach it to the network and volumes as needed.

## Cleanup Cheat Sheet

- Preserve data, just restart stack:
  ```
  make down && make
  ```
- Full reset (including data):
  ```
  make cc
  ```

## License

(Add your chosen license here, e.g. MIT, GPL-3.0, etc.)

## Author

fkuyumcu