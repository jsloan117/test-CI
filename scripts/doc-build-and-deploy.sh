#!/bin/bash
# build and deploy documentation using mkdocs

build_documentation () {
  mkdir -p "$HOME/.ssh"
  echo "${DEPLOY_KEY}" | base64 --decode > "$HOME/.ssh/id_rsa"
  chmod 600 "$HOME/.ssh/id_rsa"
  echo -e '\n<<< Setting remote origin to SSH >>>'
  git remote set-url origin git@github.com:jsloan117/test-CI.git
  echo -e '\n<<< Setting Git name for commits >>>'
  git config --global user.name 'TravisCI'
  echo -e '\n<<< Installing mkdocs & theme >>>'
  pip3 -q install mkdocs mkdocs-material pygments
  echo ''
  mkdocs build -cs
  #mkdocs gh-deploy -cm "Deployed {sha} with MkDocs version {version}. [skip ci]" --force
  echo ''
  rm -f "$HOME/.ssh/id_rsa"
}

build_documentation
