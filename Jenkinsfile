pipeline {
  environment {
    REGISTRY = 'jsloan117/test-ci'
  }
  agent any
  options {
    timestamps ()
    disableResume ()
    timeout(activity: true, time: 1, unit: 'HOURS')
    warnError('An error has occurred')
  }
/*  triggers {*/
/*    cron('H 0 *//*15 * *')
    pollSCM '''TZ=America/Chicago H/15 * * * *'''
  }*/
  parameters {
    choice(
      name: 'BRANCH',
      description: 'Branch',
      choices: ['dev', 'master']
    )
  }
  stages {
    properties([
      disableResume(),
      [$class: 'GithubProjectProperty',
        displayName: 'test-ci',
        projectUrlStr: 'https://github.com/jsloan117/test-CI/'],
      pipelineTriggers(
        [cron('H 0 */15 * *'),
        pollSCM('''TZ=America/Chicago H/15 * * * *''')
      ])
    ])
    stage('Checkout repo') {
      /* code checkout first */
      steps {
        checkout(
          [$class: 'GitSCM',
          branches: [[name: "refs/heads/${params.BRANCH}" ]], 
          doGenerateSubmoduleConfigurations: false,
          extensions: [
            [$class: 'CleanBeforeCheckout'],
            [$class: 'CheckoutOption', timeout: 5]],
          submoduleCfg: [],
          userRemoteConfigs:
            [[credentialsId: 'githubkey', url: 'git@github.com:jsloan117/test-CI.git']]
        ])
        script {
          shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
          ansiColor('xterm') {
            echo "$shortCommit"
          }
          currentBuild.displayName = "${BRANCH_NAME}-${shortCommit}-#${BUILD_NUMBER}"
        }
      }
    }
    stage('Building images') {
      /* build images */
      steps {
        script {
          if (params.BRANCH == 'dev') {
            dockerImage = docker.build("$REGISTRY:dev", "-f Dockerfile .")
            dockerImageAlt = docker.build("$REGISTRY:ubuntu-dev", "-f Dockerfile.ubuntu .")
          } else if (params.BRANCH == 'master') {
            dockerImage = docker.build("$REGISTRY:latest", "-f Dockerfile .")
            dockerImageAlt = docker.build("$REGISTRY:ubuntu-latest", "-f Dockerfile.ubuntu .")
          } else {
            dockerImage = docker.build("$REGISTRY:$BRANCH_NAME", "-f Dockerfile .")
            dockerImageAlt = docker.build("$REGISTRY:ubuntu-$BRANCH_NAME", "-f Dockerfile.ubuntu .")
          }
        }
      }
    }
    stage('Test images') {
      /* simple testing method */
      steps {
        script {
          dockerImage.inside() {
            sh 'bash --version'
          }
        }
      }
    }
    /*stage('Push images') {*/
      /* push images to Docker Hub */
      /*steps {
        script {
          if (params.BRANCH == 'dev') {
            dockerImage.push('dev')
            dockerImage.push('ubuntu-dev')
          } else if (params.BRANCH == 'master') {
            dockerImage.push('latest')
            dockerImage.push('ubuntu-latest')
          }
        }
      }
    }*/
    stage('Remove unused docker image') {
      /* remove images after push */
      steps {
        script {
          if (params.BRANCH == 'dev') {
            sh "docker rmi $REGISTRY:dev"
            sh "docker rmi $REGISTRY:ubuntu-dev"
          } else if (params.BRANCH == 'master') {
            sh "docker rmi $REGISTRY:latest"
            sh "docker rmi $REGISTRY:ubuntu-latest"
          } else {
            sh "docker rmi $REGISTRY:$BRANCH_NAME"
            sh "docker rmi $REGISTRY:ubuntu-$BRANCH_NAME"
          }
        }
      }
    }
  }
}
