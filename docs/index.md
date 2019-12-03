<h1 align="center">
  test-CI
</h1>

<p align="center">
  Simple hello-world container used to test multiple CI's.
  <br/><br/>

  <a href="https://github.com/jsloan117/test-CI/blob/master/LICENSE">
    <img alt="license" src="https://img.shields.io/badge/License-GPLv3-blue.svg" />
  </a>
  <a href="https://dev.azure.com/jsloan117/docker-containers/_build/latest?definitionId=7&branchName=dev">
    <img alt="build" src="https://dev.azure.com/jsloan117/docker-containers/_apis/build/status/test-CI?branchName=dev" />
  </a>
  <a href="https://circleci.com/gh/jsloan117/test-CI/tree/dev">
    <img alt="build" src="https://circleci.com/gh/jsloan117/test-CI/tree/dev.svg?style=svg" />
  </a>
  <a href="http://drone.macksarchive.com/jsloan117/test-CI">
    <img alt="build" src="http://drone.macksarchive.com/api/badges/jsloan117/test-CI/status.svg?ref=refs/heads/dev" />
  </a>
  <a href="https://travis-ci.org/jsloan117/test-CI">
    <img alt="build" src="https://travis-ci.org/jsloan117/test-CI.svg?branch=dev" />
  </a>
</p>

``` bash
docker run --rm -it jsloan117/test-ci

Hello, World!

```

## Requirements of a CI/CD platform

* Build multiple docker images conditionally
* Test multiple docker images
* Push multiple docker images
* Build documentation & push using mkdocs

## Platforms still being tested

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

`Codeship`: I liked the idea of it, but don't have time to figure out why I can't perform conditional execution for building containers.

`Shippable`: Is a very powerful platform but due to it being so powerful its some what complex and overkill for my needs.
