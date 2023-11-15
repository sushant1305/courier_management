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
                    def app = docker.build("courier_mgmt:${env.BUILD_ID}")
                }
            }  
        }
        stage('Sonar Scan') {
            environment {
                        SCANNER_HOME = tool 'Sonar-scanner'
                        }
            steps {
                withSonarQubeEnv(credentialsId: 'sonar-credentials', installationName: 'Sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                            -Dsonar.projectKey=dissertation \
                            -Dsonar.projectName=courier_mgmt \
                            -Dsonar.sources=views/ \
                            -Dsonar.projectVersion=${BUILD_NUMBER}-${GIT_COMMIT_SHORT}'''
                    }
                }  
        }  

        stage('Tag Image') {
            steps {
                echo 'Tag ${JOB_NAME} Image'
                script {
                        sh "docker tag courier_mgmt:${env.BUILD_ID} 192.168.0.130:5000/courier_mgmt:latest"
                    }
                }
            }
        stage('Publish Image') {
            steps {
                echo 'Publishing ${JOB_NAME}'
                script {
                        sh "docker push 192.168.0.130:5000/courier_mgmt:latest"
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

