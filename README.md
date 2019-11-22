# test-CI

Testing multiple CIs

[![Build Status](http://drone.macksarchive.com/api/badges/jsloan117/test-CI/status.svg?ref=refs/heads/dev)](http://drone.macksarchive.com/jsloan117/test-CI)
[![CircleCI](https://circleci.com/gh/jsloan117/test-CI/tree/dev.svg?style=svg)](https://circleci.com/gh/jsloan117/test-CI/tree/dev)
[![Build Status](https://travis-ci.org/jsloan117/test-CI.svg?branch=dev)](https://travis-ci.org/jsloan117/test-CI)
[![Build Status](https://dev.azure.com/jsloan117/docker-containers/_apis/build/status/test-CI?branchName=dev)](https://dev.azure.com/jsloan117/docker-containers/_build/latest?definitionId=7&branchName=dev)

This repo and docker image(s) are simply used for testing out docker builds on multiple CI platforms. Comparing each ones pros vs cons first hand.

```bash
docker run --rm -it jsloan117/test-ci

Hello, World!

```

| CI Platforms       |
|:------------------:|
| `Azure Pipelines`  |
| `CircleCI`         |
|<s> `CodeShip`</s>  |
|<s> `Concourse`</s> |
| `Drone.io`         |
| `Jenkins`          |
|<s> `Shippable`</s> |
| `TravisCI`         |

## Platforms no longer being tested

`Concourse`: While great because it's self hosted and feature rich, I don't have time to continue to try and figure out how to set this up.

`Codeship`: I liked the idea of, but unfortunately on their basic/free tier Docker is not support and is a shame.

`Shippable`: Is a very powerful platform but due to it being so powerful its some what complex and overkill for my needs.
