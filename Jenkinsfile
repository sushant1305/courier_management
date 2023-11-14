pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    /* agent { docker { image 'node:20.9.0-alpine3.18' } } */
    agent any
    stages {
        stage('Build Image') {
            steps {
                echo 'Starting to build docker image'
                script {
                    def customImage = docker.build("courier_mgmt:${env.BUILD_ID}")
                    customImage.push()
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
