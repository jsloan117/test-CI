#!/bin/bash
# build docker images and push them

set -eo pipefail

if [ "${TRAVIS_BRANCH}" = "master" ]; then
  IMAGE_TAG=latest
else
  IMAGE_TAG="${TRAVIS_BRANCH}"
fi

export IMAGE_TAG

build_images () {
  echo -e "\n<<< Building default image >>>\n"
  docker build -f Dockerfile -t "${IMAGE_NAME}":"${CI_PLATFORM}"-"${IMAGE_TAG}" .
  echo -e "\n<<< Building ubuntu image >>>\n"
  docker build -f Dockerfile.ubuntu -t $"${IMAGE_NAME}":ubuntu-"${CI_PLATFORM}"-"${IMAGE_TAG}" .
}

test_images () {
  echo -e "\n<<< Testing default image >>>\n"
  docker run --rm "${IMAGE_NAME}":"${CI_PLATFORM}"-"${IMAGE_TAG}" bash --version
  echo -e "\n<<< Testing ubuntu image >>>\n"
  docker run --rm "${IMAGE_NAME}":ubuntu-"${CI_PLATFORM}"-"${IMAGE_TAG}" bash --version
}

push_images () {
  echo -e "\n<<< Pushing default image >>>\n"
  docker push "${IMAGE_NAME}":"${CI_PLATFORM}"-"${IMAGE_TAG}"
  echo -e "\n<<< Pushing ubuntu image >>>\n"
  docker push $"${IMAGE_NAME}":ubuntu-"${CI_PLATFORM}"-"${IMAGE_TAG}"
}

build_images
test_images
#if [[ "${TRAVIS_PULL_REQUEST}" = false ]] && [[ "${TRAVIS_BRANCH}" =~ ^(dev|master)$ ]]; then
if [ "${TRAVIS_PULL_REQUEST}" = false ] && [ "${TRAVIS_BRANCH}" = master -o "${TRAVIS_BRANCH}" = dev ]; then
  push_images
fi
