#!/usr/bin/env bash

set -eu

UBUNTU_VERSION=${UBUNTU_VERSION:-20.04}
_UBUNTU_VERSION=${UBUNTU_VERSION/\./}

IMAGE="johejo/gh-actions-ubuntu"
TAG="$IMAGE:$UBUNTU_VERSION"
SHORT_HASH="$(git rev-parse --short HEAD)"
TAG2="$IMAGE:$SHORT_HASH"

docker build -t "$TAG" --build-arg "UBUNTU_VERSION=$UBUNTU_VERSION" --build-arg "_UBUNTU_VERSION=$_UBUNTU_VERSION" .
docker tag "$TAG" "$TAG2"
docker push "$TAG" "$TAG2"
