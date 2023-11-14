pipeline {
	options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
	}
    agent { docker { image 'node:20.9.0-alpine3.18' } }
    stages {
        stage('build') {
            steps {
                sh 'node --version'
            }
        }
    }
}
