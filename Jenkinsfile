pipeline {
  environment {
    IMAGE_NAME = 'jsloan117/test-ci'
    CI_PLATFORM = 'jenkins'
  }
  agent any
  options {
    timestamps ()
    disableResume ()
    timeout(activity: true, time: 1, unit: 'HOURS')
    warnError('An error has occurred')
  }
  triggers {
    cron('H 0 */15 * *')
  }
  parameters {
    choice(
      name: 'BRANCH',
      description: 'Branch',
      choices: ['dev', 'master']
    )
  }
  stages {
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
        /* get git commit hash and message */
        script {
          shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
          gitmsg = sh(returnStdout: true, script: "git log -n 1 --format='%s'").trim()
          ansiColor('xterm') {
            script {
              /* sh 'echo -e "\033[32m${shortCommit}\033[0m \033[33m${gitmsg}\033[0m\n"' */
              sh 'echo -e "Building: ${shortCommit} ${gitmsg}"'
            }
          }
          /* set build name */
          currentBuild.displayName = "${BRANCH_NAME}-${shortCommit}-#${BUILD_NUMBER}"
        }
      }
    }
    stage('Building images') {
      /* build images */
      steps {
        script {
          if (BRANCH_NAME == 'dev') {
            baseImage = docker.build("${IMAGE_NAME}:${CI_PLATFORM}-dev", "-f Dockerfile .")
            ubuntuImage = docker.build("${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-dev", "-f Dockerfile.ubuntu .")
          } else if (BRANCH_NAME == 'master') {
            baseImage = docker.build("${IMAGE_NAME}:${CI_PLATFORM}-latest", "-f Dockerfile .")
            ubuntuImage = docker.build("${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-latest", "-f Dockerfile.ubuntu .")
          } else {
            baseImage = docker.build("${IMAGE_NAME}:${CI_PLATFORM}-${BRANCH_NAME}", "-f Dockerfile .")
            ubuntuImage = docker.build("${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-${BRANCH_NAME}", "-f Dockerfile.ubuntu .")
          }
        }
      }
    }
    stage('Test images') {
      /* simple testing method */
      steps {
        script {
          baseImage.withRun()
          ubuntuImage.withRun()
          /*baseImage.inside() {
            sh 'bash --version'
          }
          ubuntuImage.inside() {
            sh 'bash --version'
          }*/
        }
      }
    }
    stage('Push images') {
      /* push images to Docker Hub */
      steps {
        script {
          if (BRANCH_NAME == 'dev') {
            baseImage.push('dev')
            ubuntuImage.push('ubuntu-dev')
          } else if (BRANCH_NAME == 'master') {
            baseImage.push('latest')
            ubuntuImage.push('ubuntu-latest')
          }
        }
      }
    }
    stage('Remove unused docker image') {
      /* remove images after push */
      steps {
        script {
          if (BRANCH_NAME == 'dev') {
            sh "docker rmi ${IMAGE_NAME}:${CI_PLATFORM}-dev"
            sh "docker rmi ${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-dev"
          } else if (BRANCH_NAME == 'master') {
            sh "docker rmi ${IMAGE_NAME}:${CI_PLATFORM}-latest"
            sh "docker rmi ${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-latest"
          } else {
            sh "docker rmi ${IMAGE_NAME}:${CI_PLATFORM}-${BRANCH_NAME}"
            sh "docker rmi ${IMAGE_NAME}:ubuntu-${CI_PLATFORM}-${BRANCH_NAME}"
          }
        }
      }
    }
    stage('Build documentation') {
      /* build documentation using mkdocs */
      /* Jenkins running in a container is causing issues for mounting volumes */
      when {
        branch 'master'
      }
      steps {
        script {
          sh '''
            export PATH=${PATH}:${HOME}/.local/bin
            pip3 -q install --user mkdocs mkdocs-material pygments
            mkdocs build -cs
          '''
        }
      }
    }
  }
}

/*
The below is multiple attempts at getting jenkins container to pass its volume
into the mkdocs container (unsuccessfully). Leaving for notes/progress 4 now.
*/
/* sh '''
             #docker run --rm -v $(pwd):/docs jsloan117/docker-mkdocs ls -lh /docs
             #docker run --rm --volumes-from jenkins jsloan117/docker-mkdocs bash -c "useradd -r -M -u 1000 -U jenkins; su jenkins -c "cd /var/jenkins_home/workspace/docker_containers_test-CI_dev && mkdocs build""
             #docker run --rm -v /var/lib/docker/volumes/jenkins_home/_data/$(pwd):/docs jsloan117/docker-mkdocs ls -lh /docs
             ''' */
          /*
          docker.image('jsloan117/docker-mkdocs:latest').withRun("-v ${WORKSPACE}:/docs", "mkdocs build") {
            sh 'mkdocs build'
          }*/

/*stage('Build documentation') {
      agent {
        docker {
          image 'jsloan117/docker-mkdocs:latest'
          args '-v $PWD:/docs mkdocs build'
        }
      }
      when {
        beforeAgent true
        branch 'dev'
      }
      steps {
        echo 'one'
      }
    }*/
