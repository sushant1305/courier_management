pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    /* agent { docker { image 'node:20.9.0-alpine3.18' } } */
    agent any
    stages {
        stage('Build Image') {
            steps {
                echo 'Starting to build ${JOB_NAME}'
                script {
                    def customImage = docker.build("courier_mgmt:${env.BUILD_ID}")
                }
            }  
        }
        stage('Publish Image') {
            steps {
                echo 'Publishing ${JOB_NAME}'
                script {
                        docker.withRegistry('192.168.0.130:5000') {
                        dockerImage.push()
                    }
                }
            }  
        }
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
    }
}
