# test-CI

Testing multiple CIs

[![images](https://github.com/jsloan117/test-CI/actions/workflows/images.yml/badge.svg)](https://github.com/jsloan117/test-CI/actions/workflows/images.yml)

This repo and docker image(s) are used for testing out docker builds on multiple CI platforms. Comparing each ones pros vs cons first hand.

```bash
docker run --rm -it jsloan117/test-ci

Hello, World!

```

## Requirements of a CI/CD platform

* Build multiple docker images conditionally
* Test multiple docker images
* Push multiple docker images
* Build documentation & push using mkdocs

## Platforms still being tested

| CI Platforms              |
|:-------------------------:|
|<s> `Azure Pipelines`</s>  |
|<s> `CircleCI`</s>         |
|<s> `CodeShip`</s>         |
|<s> `Concourse`</s>        |
|<s> `Drone.io`</s>         |
| `Github actions`          |
|<s> `Jenkins`</s>          |
|<s> `Shippable`</s>        |
| `TravisCI`                |

## Platforms no longer being tested

`Concourse`: While great because it's self hosted and feature rich, I don't have time to continue to try and figure out how to set this up.

`Codeship`: I liked the idea of it, but don't have time to figure out why I can't perform conditional execution for building containers.

`Shippable`: Is a very powerful platform but due to it being so powerful its some what complex and overkill for my needs.
