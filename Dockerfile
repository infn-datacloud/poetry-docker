ARG PYTHON_VERSION=3.13
ARG PYTHON_VARIANT=slim

FROM python:${PYTHON_VERSION}-${PYTHON_VARIANT} AS poetry

ARG POETRY_VERSION=2.1.4

ENV POETRY_HOME=/opt/poetry \
    POETRY_VERSION=${POETRY_VERSION} \
    POETRY_VIRTUALENVS_CREATE=false \
    PATH=${PATH}:/opt/poetry/bin

RUN python -m ensurepip --upgrade \
    && python -m pip install --upgrade pip poetry setuptools

FROM poetry AS non-root-poetry

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV PATH=:$PATH/home/${USERNAME}/.local/bin \
    USERNAME=${USERNAME}

# Create a user with the given name, UID and GID 
# Add the user to the sudoers, to allow to execute commands 
# requiring sudoers permissions (such as apt install).
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME