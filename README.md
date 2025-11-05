# Alpine PHP 8.5 Docker Image

This repo builds the `mgldvd/alpine-php85` Docker image on top of `alpine:latest`, adding Bash tooling and PHP 8.5.

- GitHub: https://github.com/Mgldvd-Docker/alpine-php85
- Docker Hub: https://hub.docker.com/r/mgldvd/alpine-php85

## Overview

Single Dockerfile using Alpine + Vim, published by the GitHub Actions workflow on `deploy/hub`.

### Packages installed via `apk add`

- `bash`
- `sudo`
- `curl`
- `neovim`
- `coreutils`
- `php85`
- `php85-cli`
- `php85-fpm`
- `php85-mbstring`
- `php85-curl`
- `php85-zip`
- `php85-xml`
- `php85-dom`
- `php85-pdo`
- `php85-pdo_mysql`

## Image Tags

| Tag | Description |
| --- | --- |
| `latest` | Most recent successful build on `deploy/hub` |


## Building Locally

Clone the project and build the image using the provided Dockerfile:

```sh
# Clone the repo
git clone https://github.com/Mgldvd-Docker/alpine-php85.git
cd alpine-php85

# Build the image locally
docker build -t mgldvd/alpine-php85:local .
```

Run the container to verify the build:

```sh
docker run --rm -it mgldvd/alpine-php85:local bash
```

## Publishing Workflow

The GitHub Actions workflow at `.github/workflows/docker-publish.yml` automates image publication. It performs the following steps:

1. Checks out the repository.
2. Prepares Docker Buildx for multi-platform builds.
3. Authenticates against Docker Hub using repository secrets.
4. Generates OCI metadata, including links back to GitHub and Docker Hub.
5. Builds the image and pushes both the `latest` and commit-specific tags.

### Required Secrets

Add the following secrets in the GitHub repository settings before running the workflow:

- `DOCKERHUB_USERNAME`: Docker Hub account name (e.g., `mgldvd`).
- `DOCKERHUB_TOKEN`: Docker Hub access token with permission to push the repository.

### Triggering a Publish

Push commits to the `deploy/hub` branch or run the workflow manually from the GitHub Actions tab to build and publish a new image version.

## Contributing

Issues and pull requests are welcome. Please open a discussion in the GitHub repository if you plan substantial changes so proposals can be coordinated with the publishing workflow.
