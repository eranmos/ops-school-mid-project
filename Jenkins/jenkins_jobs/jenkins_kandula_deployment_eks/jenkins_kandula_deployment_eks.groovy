properties([
  parameters([
    booleanParam(name: 'Deploy_In_Prod', defaultValue: false, description: 'Check this box to deploy Knadula app on Prod'),
    string(name: 'IMAGE_NAME', trim: true, defaultValue: 'ops-school-kandula', description: 'The name of the docker image, defaultValue: ops-school-kandula'),
    string(name: 'IMAGE_TAG', trim: true, defaultValue: '', description: 'Set image tag for new jenkins slave for example, stable-1.0.0'),
    ])
])

pipeline {

    agent {
        label 'docker-ubuntu'
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
        stage('Cleaning up Docker image') {
            steps {
                echo "eran test"
            }
        }
        stage('Preparing the deployment file') {
            when {
               expression { params.deploy == true }
            }
             steps {
             withCredentials([string(credentialsId: 'aws.access_key', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws.secret_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh """
                                 tee kalandula_app.yaml <<-'EOF'
                                 apiVersion: apps/v1
                                 kind: Deployment
                                 metadata:
                                   name: kanduka-app
                                   annotations:
                                     kubernetes.io/change-cause: "First release of kandula app"
                                 spec:
                                   replicas: 1
                                   selector:
                                     matchLabels:
                                       app: kandula-app
                                   template:
                                     metadata:
                                       labels:
                                         app: kandula-app
                                     spec:
                                       containers:
                                         - name: kandula
                                           image: erandocker/ops-school-kandula:latest
                                           env:
                                             - name: FLASK_ENV
                                               value: "development"
                                             - name: AWS_ACCESS_KEY_ID
                                               value: "${AWS_ACCESS_KEY_ID}"
                                             - name: AWS_SECRET_ACCESS_KEY
                                               value: "${AWS_SECRET_ACCESS_KEY}"
                                             - name: AWS_DEFAULT_REGION
                                               value: "us-east-1"
                                           ports:
                                             - containerPort: 5000
                                               name: http
                                               protocol: TCP
                             """
                }
            }
        }
        stage('Deploying Kandula on EKS prod') {
            when {
               expression { params.deploy == true }
            }
            steps {
                sh "aws eks --region=us-east-1 update-kubeconfig --name opsschool-eks-kandula-prod"
                sh "kubectl get nodes -o wide"
                sh "kubectl apply -f kalandula_app.yaml"
                sh "sleep 10"
                sh "kubectl get pods -o wide"
            }
        }
        stage('Deploying LB in EKS Prod') {
            when {
               expression { params.deploy == true }
            }
            steps {
                dir ("terraform_eks/") {
                    sh "pwd"
                    sh "ls -laht"
                    sh "kubectl apply -f kandula_lb.yaml"
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