# Docker

Docker publisher orb project comes already with prepared setup for running circleci client.

## Pre-requirements

- **Docker desktop** - Instructions for installing Docker desktop on your machine can be found on [Get Docker](https://docs.docker.com/get-docker/).
- **CircleCi Token** - Instructions on generating personal API token can be found here ([Managing Api Tokens](https://circleci.com/docs/2.0/managing-api-tokens/)). After you obtain
your personal API token you should create `cli.yml` in `<your-home-dir>\.circleci` (example: `C:\Users\SomeUser\.circleci`) that should contain:
  
```yaml
  
  host: https://circleci.com
  endpoint: graphql-unstable
  token: <your-circleci-access-token>
  rest_endpoint: api/v2
  orb_publishing:
    default_namespace: serbiatech
    default_vcs_provider: github
    default_owner: serbiatech
  
  ```
- **USER_CIRCLECI_DIR and USER_PROJECTS_DIR** - In `docker/.env` set this two variable according to your host setup (example: `USER_CIRCLECI_DIR=/c/Users/SomeUser/.circleci`, `USER_PROJECTS_DIR=/c/Users/SomeUser/Projects`)

## Running orb-cli container

To build and run orb-cli container type:`cd docker` and then `docker-compose up -d`. After container is build you can access container by typing `docker-compose exec orb-cli bash`.

## Running jobs

You can execute jobs on local machine by typing `docker-compose exec orb-cli make local-execute <job-name>`, but there are also predifined job commands:

- **docker-compose exec orb-cli make lint** - executes `orb-tools/lint` job.
- **docker-compose exec orb-cli make pack** - executes `orb-tools/pack` job.
- **docker-compose exec orb-cli make shellcheck** - executes `shellcheck/check` job.
- **docker-compose exec orb-cli make bats** - executes `bats/run` job.

## Stopping container and removing images

For stopping container type `docker-compose down` and for removing all images type `docker system prune -a` and then `y`.



