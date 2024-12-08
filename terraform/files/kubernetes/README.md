# Local Kubernetes cluster

It creates the following pods:

- `web`: The application itself, running on port `5000`. It is a Flask application that exposes a REST API.
- `postgres`: A PostgreSQL database with persistent storage.

> [!CAUTION]
> Environment is configured to `development`. Do not use it in production.

## Prerequisites

It uses `kubectl` to develop and run the application. Also, `make` is used to simplify the process of building, running and testing the application.

You need to have both services installed on your machine:

- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [`make`](https://www.gnu.org/software/make/)

## How to use

Just run the following command to list the available recipes:

```bash
make
```

## Test the API

You can interact with the API by running the following commands:

```bash
curl -H "Content-Type: application/json" -X GET http://$WEB_CLUSTER_IP:5000/data
curl -H "Content-Type: application/json" -X POST -d '{"name":"test"}' http://$WEB_CLUSTER_IP:5000/data
curl -H "Content-Type: application/json" -X DELETE http://$WEB_CLUSTER_IP:5000/data/2
```