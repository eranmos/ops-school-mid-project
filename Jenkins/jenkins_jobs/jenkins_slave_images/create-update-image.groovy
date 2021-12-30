properties([
  parameters([
    choice(
        name: 'IMAGE_NAME',
        defaultValue: '',
        choices: ['jenkins-slave-ubuntu-18.4',
                  'jenkins-slave-docker-ansible',
                  'jenkins-slave-docker-centos7'],
        description: 'Please select the Jenkins docker Image that you would like to build'
        ),
    string(name: 'IMAGE_TAG', trim: true, defaultValue: '', description: 'Set image tag for new jenkins slave for example, stable-1.0.0'),
    ])
])

pipeline {

    agent {
        label 'jenkins-slave'
    }

    environment{
        REGISTRY = "erandocker"
        REGISTRY_CREDENTIAL = 'dockerhub.erandocker'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
    }

    stages {
        stage("Build Jenkins Slave Docker Image") {
            steps {
                dir ("${env.IMAGE_NAME}") {
                    sh "pwd"
                    sh "ls -la"
                    sh "docker image build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
                }
            }
        }
        stage("Publish Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub.erandocker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}'
                }
            }
        }
        stage('Cleaning up Docker image') {
            steps {
                sh "docker rmi ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }

    post {
        success {
            slackSend(
                color: 'good',
                message: "SUCCESSFUL: Job ${env.JOB_NAME} - #${env.BUILD_NUMBER} - (<${env.BUILD_URL}|Open>)"
            )
        }
        failure {
            slackSend(
                color: 'danger',
                message: "FAILED: Job ${env.JOB_NAME} - #${env.BUILD_NUMBER} - (<${env.BUILD_URL}|Open>)"
            )
        }
    }
}