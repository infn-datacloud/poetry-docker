ARG PYTHON_VERSION=3.13
ARG PYTHON_VARIANT=slim

FROM python:${PYTHON_VERSION}-${PYTHON_VARIANT} AS base

ARG POETRY_VERSION=2.1.4

ENV POETRY_HOME=/opt/poetry \
    POETRY_VERSION=${POETRY_VERSION} \
    POETRY_VIRTUALENVS_CREATE=false \
    PATH=${PATH}:/opt/poetry/bin

RUN python -m ensurepip --upgrade \
    && python -m pip install --upgrade setuptools pip poetry
