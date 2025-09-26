# poetry-docker

Docker Image, based on python, with poetry.

This image:
- Is based on python3 image (python version and variant can be chose)
- Uses latest version of pip and setuptools
- Installs poetry (poetry version can be chosen)
- Create a non-root user with sudoers privileges (**when using this image as base, the current user is still root**)

The following arguments can be passed at build time to configure the image:
- PYTHON_VERSION (default is `3.13`)
- PYTHON_VARIANT (default is `slim`)
- POETRY_VERSION (default is `2.1.4`)
- USERNAME (default is `userapp`)
- USER_UID (default is `1000`)
- USER_GID (default is `$USER_UID`)

# Usage example

Here a Dockerfile example using this image.

```Dockerfile
ARG PYTHON_VERSION=3.12
ARG POETRY_VERSION=2.1

FROM indigopaas/poetry:${POETRY_VERSION}-${PYTHON_VERSION}

WORKDIR /app

# Copy and install files as root user
COPY ./pyproject.toml ./poetry.lock ./README.md /app/

RUN poetry install

# Set user as non-root user
USER ${USERNAME}
```