pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    agent any
    stages {
        stage('Build Image') {
            steps {
                echo 'Starting to build docker image'
                script {
                    sh 'docker version'
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
