properties([
  parameters([
    booleanParam(name: 'Deploy_In_Prod_Kandula', defaultValue: false, description: 'Check this box to deploy Knadula app on Prod'),
    booleanParam(name: 'Deploy_In_Prod_LB', defaultValue: false, description: 'Check this box to deploy Knadula app on Prod'),
    string(name: 'IMAGE_NAME', trim: true, defaultValue: 'ops-school-kandula', description: 'The name of the docker image, defaultValue: ops-school-kandula'),
    string(name: 'IMAGE_TAG', trim: true, defaultValue: '', description: 'Set image tag for new jenkins slave for example, stable-1.0.0'),
    ])
])

pipeline {

    agent {
        label 'jankins-slave-ec2'
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
        stage("Build Kandula Docker Image") {
            steps {
                dir (".") {
                    sh "pwd"
                    sh "ls -la"
                    sh "docker image build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile ."
                    sh "docker tag ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }
        stage("Publish Image") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub.erandocker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}'
                    sh 'docker push ${REGISTRY}/${IMAGE_NAME}:latest'
                }
            }
        }
        stage('Cleaning up Docker image') {
            steps {
                sh "docker rmi ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker rmi ${REGISTRY}/${IMAGE_NAME}:latest"
            }
        }
        stage('Preparing the deployment file') {
            when {
               expression { params.Deploy_In_Prod_Kandula == true }
            }
             steps {
             withCredentials([string(credentialsId: 'aws.access_key', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws.secret_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                sh """
                                 tee kalandula_app.yaml <<-'EOF'
                                 apiVersion: apps/v1
                                 kind: Deployment
                                 metadata:
                                   name: kandula-app
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
                                         - name: kandula-app
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
               expression { params.Deploy_In_Prod_Kandula == true }
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
               expression { params.Deploy_In_Prod_LB == true }
            }
            steps {
                dir ("terraform_eks/") {
                    sh "pwd"
                    sh "ls -laht"
                    sh "kubectl apply -f kandula_lb.yaml"
                    sh "sleep 20"
                    sh " kubectl get services -o wide"
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