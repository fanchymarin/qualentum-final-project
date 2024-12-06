# Local deployment

This deployment is intended to be used for development and testing purposes. It creates the following services:

- `app`: The application itself, running on `127.0.0.1:5000`. It is a Flask application that exposes a REST API.
- `db`: A PostgreSQL database with persistent storage.
- `db-test`: An ephemeral PostgreSQL database for testing purposes.

> [!CAUTION]
> Environment is configured to `development`. Do not use it in production.

## Prerequisites

It uses `docker compose` to develop, run and test the application locally. Also, `make` is used to simplify the process of building, running and testing the application.

You need to have both services installed on your machine:

- [`docker`](https://docs.docker.com/get-docker/)
- [`make`](https://www.gnu.org/software/make/)

## How to use

Just run the following command to list the available recipes:

```bash
make
```

## Test manually

You can test the application manually by running the following commands:

```bash
curl -H "Content-Type: application/json" -X GET http://127.0.0.1:5000/data
curl -H "Content-Type: application/json" -X POST -d '{"name":"test"}' http://127.0.0.1:5000/data
curl -H "Content-Type: application/json" -X DELETE http://127.0.0.1:5000/data/2
```