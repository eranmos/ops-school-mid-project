pipeline {
    agent {
        label 'jankins-slave-ec2'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '25'))
        disableConcurrentBuilds()
    }

    stages {
        stage("provisioning servers") {
            steps {
                dir ("ansible/") {
                    sh "pwd"
                    sh "ls -lhta"
                    sh "ansible-playbook common_ansible_playbook.yaml"
                }
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